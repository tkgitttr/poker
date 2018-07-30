module API
  class Root < Grape::API
    # http://localhost:3000/api/
    prefix 'api'

    # 未指定の場合にJSONで返すように変更（URLで指定可能）
    format :json

    helpers do
      def my_error!(message)
        error!({"error":[{"msg": message}]},404)
      end
    end

    # rescueはmountの前に記述する必要あり
    rescue_from Grape::Exceptions::Base do |e|
      my_error!("不正なリクエストです．")
    end

    mount API::Ver1::Root

    # 404NotFoundの扱い mountの後に記述する必要あり
    route :any, '*path' do
      my_error!("不正なURLです．")
    end
    route :any  do
      my_error!("不正なURLです．")
    end
  end
end
