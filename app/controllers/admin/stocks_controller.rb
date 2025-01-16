class Admin::StocksController < AdminController
  before_action :set_product
  before_action :set_stock, only: %i[show edit update destroy]

  # GET /admin/product/1/stocks
  def index
    @stocks = @product.stocks
  end

  # GET /admin/product/1/stocks/1
  def show
  end

  # GET /admin/product/1/stocks/new
  def new
    @stock = Stock.new
  end

  # GET /admin/product/1/stocks/1/edit
  def edit
  end

  # POST /admin/product/1/stocks
  def create
    @stock = @product.stocks.build(stock_params)

    respond_to do |format|
      if @stock.save
        format.html { redirect_to admin_product_stock_path(@product, @stock), notice: "Stock was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/product/1/stocks/1
  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to admin_product_stock_path(@product, @stock), notice: "Stock was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/product/1/stocks/1
  def destroy
    @stock.destroy!

    respond_to do |format|
      format.html { redirect_to admin_product_stocks_path(@product), status: :see_other, notice: "Stock was successfully destroyed." }
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_stock
    @stock = @product.stocks.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def stock_params
    params.require(:stock).permit(:size, :amount, :product_id)
  end
end
