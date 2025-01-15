class Admin::ProductsController < AdminController
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /admin/products or /admin/products.json
  def index
    @products = Product.all
  end

  # GET /admin/products/1 or /admin/products/1.json
  def show
  end

  # GET /admin/products/new
  def new
    @product = Product.new
  end

  # GET /admin/products/1/edit
  def edit
  end

  # POST /admin/products or /admin/products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to [:admin, @product], notice: "Product was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/products/1 or /admin/products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        if params[:product][:remove_image_ids].present?
          @product.images.where(id: params[:product][:remove_image_ids].split(",").map(&:to_i)).map(&:purge)
        end

        if params[:product][:images].present?
          @product.images.attach(params[:product][:images])
        end

        format.html { redirect_to [:admin, @product], notice: "Product was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/products/1 or /admin/products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to admin_products_path, status: :see_other, notice: "Product was successfully destroyed." }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id, :active)
  end
end
