require "test_helper"

class ProductsControllertest < ActionDispatch::IntegrationTest
  test "render a list of products" do
    get products_path

    assert_response :success
    assert_select ".product", 2
  end

  test "render a detailed product page" do
    get product_path(products(:ps4))

    assert_response :success
    assert_select ".title", "PS4 Fat"
    assert_select ".prince", "$ 150"
    assert_select ".description", "Ps4 good"
  end

  test "render a new product form" do
    get new_product_path

    assert_response :success
    assert_select "form"
  end

  test "allow to create a new product" do
    post products_path, params:{
      product: {
        title: "nintendo",
        description: "nothing",
        prince: 45
      }
    }

    assert_redirected_to products_path
    assert_equal flash[:notice], "Product saved successfully"
  end

  test "does not allow to create a new product with empty field" do
    post products_path, params:{
      product: {
        title: "",
        description: "nothing",
        prince: 45
      }
    }

    assert_response :unprocessable_entity
  end

  test "render an edit product form" do
    get edit_product_path(products(:ps4))

    assert_response :success
    assert_select "form"
  end

  test "allow to update a product" do
    patch product_path(products(:ps4)), params:{
      product: {
        title: "nintendo",
        description: "nothing",
        prince: 165
      }
    }

    assert_redirected_to products_path
    assert_equal flash[:notice], "Product updated successfully"
  end

  test "does not allow to update a product with an invalid field" do
    patch product_path(products(:ps4)), params:{
      product: {
        prince: nil
      }
    }

    assert_response :unprocessable_entity
  end

end
