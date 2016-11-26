class ReviewsController < ApplicationController

  before_filter :authorize

  def create
    user_id = User.find_by_id(session[:user_id])
    @product = Product.find(params[:product_id])
    @CheckForReview = Review.where('user_id = ? AND product_id = ?', user_id, params[:product_id])
    pp @CheckForReview
    if @CheckForReview.length != 0
      redirect_to product_path(@product), notice: 'User already commented on this product'
    else
      @review = @product.reviews.create(review_params)
      redirect_to product_path(@product)
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @review = @product.reviews.find(params[:id])
    @review.destroy
    redirect_to product_path(@product)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :description, :user_id)
  end
end
