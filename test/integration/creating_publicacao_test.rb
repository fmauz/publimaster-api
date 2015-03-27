require 'test_helper'

class CreatingPublicacaoTest < ActionDispatch::IntegrationTest

  setup do
    @client = FactoryGirl.create(:client)
  end

  test "creating a new publicacao" do
    objectCreated = {
      publicacao: FactoryGirl.attributes_for(:publicacao)
    }

    objectCreated[:publicacao][:client_id] = @client.id

    post "/publicacaos", objectCreated, {}

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    publicacao_object = Publicacao.find( json( response.body )["publicacao"]["id"] )

    assert_equal objectCreated[:publicacao][:client_id], publicacao_object.client_id
    assert_equal objectCreated[:publicacao][:price], publicacao_object.price
    assert_equal objectCreated[:publicacao][:publication_date_diario_oficial].to_date, publicacao_object.publication_date_diario_oficial
    assert_equal objectCreated[:publicacao][:publication_date_jornal].to_date, publicacao_object.publication_date_jornal
    assert_equal objectCreated[:publicacao][:height_jornal], publicacao_object.height_jornal
    assert_equal objectCreated[:publicacao][:coluna_jornal], publicacao_object.coluna_jornal
    assert_equal objectCreated[:publicacao][:total_jornal], publicacao_object.total_jornal
    assert_equal objectCreated[:publicacao][:diario_oficial_id], publicacao_object.diario_oficial_id
    assert_equal objectCreated[:publicacao][:jornal_id], publicacao_object.jornal_id
    assert_equal objectCreated[:publicacao][:jornal_material_id], publicacao_object.jornal_material_id
    assert_equal objectCreated[:publicacao][:diario_oficial_material_id], publicacao_object.diario_oficial_material_id
  end

  test "creating a new material with a invalid params" do
    invalidObject = { publicacao: { price: nil } }
    post "/publicacaos", invalidObject, {}

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type

    jsonObject = json( response.body )

    assert jsonObject["client"].include? "can't be blank"
    assert jsonObject["price"].include? "can't be blank"
  end
end
