module TencentWeibo
  module Api
    module V2

      class Status < Base

        @url_prefix = 'statuses'

        get_methods :home_timeline,:home_timeline_ids,:home_timeline_vip,:broadcast_timeline,:broadcast_timeline_ids,
                    :user_timeline,:user_timeline_ids,:users_timeline,:users_timeline_ids,:mentions_timeline,
                    :mentions_timeline_ids,:special_timeline,:public_timeline,:area_timeline,:ht_timeline_ext,
                    :get_micro_album,:sub_re_list

        def get_url_prefix
          @url_prefix
        end

      end

    end
  end
end