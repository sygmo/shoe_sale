class ProductController < ApplicationController
  def index
    @user = User.find_by(id: session[:logged_in_as])
    @products = Product.all
    @product = Product.new
  end

  def new
    # if issue pops up, check here first
  end

  def show
    @user = User.find_by(id: session[:logged_in_as])
    @product = Product.new
    @my_products = @user.products
    @purchases = @user.purchases
    @sales = @user.sales
  end

  def create
    product = Product.new(params.require(:product).permit(:user_id, :name, :amount))
    if !product.valid?
      return render 'show'
    end
    product.save
    redirect_to '/shoes'
  end

  def buy
    Purchase.create(user_id:session[:logged_in_as], product_id:params[:id], seller_id:Product.find(params[:id]).user_id)
    Sale.create(user_id:Product.find(params[:id]).user_id, product_id:params[:id], buyer_id:session[:logged_in_as])
    redirect_to :controller => 'product', :action => 'show', id: session[:logged_in_as]
  end

  def edit
  end

  def update
  end

  def destroy
    Product.find(params[:id]).delete
    redirect_to :controller => 'product', :action => 'show', id: session[:logged_in_as]
  end
end
