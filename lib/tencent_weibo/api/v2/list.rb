module TencentWeibo
  module Api
    module V2

      class List < Base

        @url_prefix = 'list'

        post_methods :add_to_list,:create,:delete,:follow,:get_other_in_list,:list_followers,
                     :listusers,:check_user_in_list,:del_from_list,:edit,:get_list,:list_attr,
                     :list_info,:myfollowlist, :undo_follow

        get_methods :timeline

        def get_url_prefix
          @url_prefix
        end

      end

    end
  end
end