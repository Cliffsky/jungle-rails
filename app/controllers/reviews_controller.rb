class ReviewsController < ApplicationController

  before_filter :authorize

  def create
    @product = Product.find(params[:product_id])
    @CheckForReview = Review.where('user_id = ? AND product_id = ?', params[:user_id], params[:product_id])
    puts @CheckForReview
    # if @CheckForReview
    #   redirect_to product_path(@product), notice: 'User already commented on this product'
    # else
    #   @review = @product.reviews.create(review_params)
    # end
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
