class Admin::SchoolsController < ApplicationController
  before_filter :set_school, only: [:edit, :update, :destroy]
  before_filter :get_users, only: [:new, :create, :edit, :update]
  #before_action :require_superadmin, excpet: [:updateschool] 
  
  require 'will_paginate/array'

  def index
    @o_single = School.new
    
    session[:search_params] = params[:school] ? params[:school] : nil

    session[:set_pager_number] = params[:set_pager_number] if params[:set_pager_number]

    if session[:set_pager_number].nil?
      session[:set_pager_number] = PER_PAGE
    end

    @schools = School.order(sort_column + " " + sort_direction).paginate(:per_page => session[:set_pager_number], :page => params[:page])

    @params_arr = ['name']

  end

  def new
    @o_single = School.new
  end

  def create
    @o_single = School.new(school_params)
    flash[:notice] = nil
    if @o_single.save
      flash[:notice] = 'School was successfully created.'
    end
  end

  def edit
  end

  def update
    @o_single = School.find(params[:id])
    flash[:notice] = nil
    if @o_single.update_attributes(school_params)
      flash[:notice] = 'School was successfully updated.'
    end    
  end

  def destroy
    @o_single.destroy
    flash[:notice] = 'School was successfully deleted.'

    session[:search_params] = params[:school] ? params[:school] : nil

    session[:set_pager_number] = params[:set_pager_number] if params[:set_pager_number]

    if session[:set_pager_number].nil?
      session[:set_pager_number] = PER_PAGE
    end

    @schools = School.order(sort_column + " " + sort_direction).paginate(:per_page => session[:set_pager_number], :page => params[:page])
    
  end

  def updateschool
    begin
      @users = User.joins(:role).where(:roles => {:role_type => "Admin"})
      @o_single = School.find(params[:id])
    rescue => ex
      
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school
      @o_single = School.find(params[:id])
    end

    def destroy_all_selected
      if params[:rec]
        id_arrs = params[:rec].collect { |k, v| k }
        School.find(id_arrs).map(&:destroy)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def school_params
      params.require(:school).permit!
    end

    def set_header_menu_active
      @users = "active"
    end

    def sort_column
      School.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end

    def get_users
      @users = User.joins(:role).where(:roles => {:role_type => "Admin"})
    end

end
