module API
  module Ver1
    # class Cards < Grape::API
      class Hoge
        #modelのpathが結びついてない
        @hoge = Hoge.new(name: "foobar", text: "hogehoge")
        @hoge.save
      end
    # end
  end
end
