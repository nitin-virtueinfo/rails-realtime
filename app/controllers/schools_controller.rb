class SchoolsController < ApplicationController
  require 'will_paginate/array'
  before_action :require_admin

  def index
    @o_single = School.new
    items_per_page = PER_PAGE

    if params[:page]
      page_count = params[:page].to_i
      total_limit = page_count * items_per_page
      session[:total_limit] = total_limit
    else
      page_count = 1
      total_limit = page_count * items_per_page
      session[:total_limit] = session[:total_limit] ? session[:total_limit] : total_limit
    end    
    
    school_query = current_user.schools.order("id desc")
    
    if (params[:school].present? and params[:school][:name].present?)
      params[:page] = params[:page] ? params[:page] : 1
      school_query = School.limit(session[:total_limit].to_i).order("id desc").all
      school_query = school_query.select {|s| s.name.include? params[:school][:name]}
    end

    if !params[:page] and !params[:school]
      session[:total_limit] = nil
    end
    
    @schools = school_query.paginate(:page => params[:page], :per_page => items_per_page)

    @params_arr = ['name']

  end
end
