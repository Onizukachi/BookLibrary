class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]
  def show
    @products = @category.products
    @products = @products.where("price >= ?", params[:min].to_i) if params[:min].present?
    @products = @products.where("price <= ?", params[:max].to_i) if params[:max].present?
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end