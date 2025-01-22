class Admin::OrdersController < AdminController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /admin/orders
  def index
    @orders = Order.order(created_at: :asc).includes(:products)
    @fulfilled_orders_pagy, @fulfilled_orders = pagy(@orders.where(fulfilled: true), page_param: :page_fulfilled)
    @unfulfilled_orders_pagy, @unfulfilled_orders = pagy(@orders.where(fulfilled: false), page_param: :page_unfulfilled)
  end

  # GET /admin/orders/1
  def show
  end

  # GET /admin/orders/new
  def new
    @order = Order.new
  end

  # GET /admin/orders/1/edit
  def edit
  end

  # POST /admin/orders
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to [:admin, @order], notice: "Order was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/orders/1
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to [:admin, @order], notice: "Order was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/orders/1
  def destroy
    @order.destroy!

    respond_to do |format|
      format.html { redirect_to admin_orders_path, status: :see_other, notice: "Order was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:email, :fulfilled, :total, :address)
    end
end
