module TencentWeibo
  module Api
    module V2

      class TWeibo < Base

        @url_prefix = "t"

        get_methods :list, :re_count, :sub_re_count, :re_list, :show

        post_methods :getvideoinfo, :add, :add_pic_url, :add_emotion, :add_music, :add_video,
                     :add_multi, :re_add, :del, :reply, :comment

        def get_url_prefix
          @url_prefix
        end

        def add_pic(content, opt)
          opt = get_opt opt
          multipart = build_multipart_bodies({:content => content, :pic => pic}.merge(opt), opt)
          hashie post("#{@url_prefix}/add_pic", :headers => multipart[:headers], :body => multipart[:body])
        end

        def upload_pic(pic, opt)
          opt = get_opt opt
          multipart = build_multipart_bodies({:pic => pic}.merge(opt), opt)
          hashie post("#{@url_prefix}/upload_pic", :headers => multipart[:headers], :body => multipart[:body])
        end

      end
    end
  end
end