# module ErrorFormatter
#   def self.call message, backtrace, options, env
#     if message.is_a?(Hash)
#       { error: message[:message], code: message[:code] }.to_json
#     else
#       { error: message }.to_json
#     end
#   end
# end

module API
  class Root < Grape::API
    # error_formatter :json, ErrorFormatter #エラーハンドリングテスト．消す

    # http://localhost:3000/api/
    prefix 'api'

    # 未指定の場合にJSONで返すように変更（URLで指定可能）
    format :json

    mount API::Ver1::Root

    helpers do
      def my_error!(message, error_code, status)
        # error!({message: message, code: error_code}, status)
        error!("error":[{"msg": "不正なURLです。"}])
      end
    end

    ###############################
    # # 例外ハンドル 404
    # rescue_from ActiveRecord::RecordNotFound do |e|
    #   rack_response({ message: e.message, status: 404 }.to_json, 404)
    # end
    # # 例外ハンドル 400
    # rescue_from Grape::Exceptions::ValidationErrors do |e|
    #   rack_response e.to_json, 400
    # end
    #
    # # 例外ハンドル 500
    # rescue_from :all do |e|
    #   if Rails.env.development?
    #     raise e
    #   else
    #     error_response(message: "Internal server error", status: 500)
    #   end
    # end
    ##################################

    # # 例外ハンドル 404
    # # rescue_from Grape::Exceptions::Base do |e|
    # rescue_from ActiveRecord::RecordNotFound do |e|
    #   rack_response({ message: e.message, status: 404 }.to_json, 404)
    # end


    ###############################
    # # 例外ハンドル 400
    # rescue_from Grape::Exceptions::ValidationErrors do |e|
    #   rack_response e.to_json, 400
    # end
    #
    # # 例外ハンドル 500
    # rescue_from :all do |e|
    #   if Rails.env.development?
    #     raise e
    #   else
    #     error_response(message: "Internal server error", status: 500)
    #   end
    # end
    #########################

    # ###############################
    # # Grapeの例外の場合は400を返す
    # rescue_from Grape::Exceptions::Base do |e|
    #   error!(e.message, 400)
    # end
    #
    # # それ以外は500
    # rescue_from :all do |e|
    #   error!({error: e.message, backtrace: e.backtrace[0]}, 500)
    # end
    ###############################

    # 404NotFoundの扱い
    route :any, '*path' do
      # error! I18n.t('不正なURLです.'), 404
      # error! ('不正なURLです.'), 404
      my_error!("不正なURLです．", 123, 404)
      # error! (('不正なURLです.').to_json), 404
      # errors.add("不正なURLです. "),404
    end

  end
end
