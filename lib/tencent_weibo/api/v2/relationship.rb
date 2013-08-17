module TencentWeibo
  module Api
    module V2

      class Relationship < Base

        @url_prefix = "friends"

        get_methods :fanslist,:fanslist_name,:fanslist_s, :user_fanslist,:idollist, :idollist_name,
                    :idollist_s,:user_idollist,:speciallist,:user_speciallist, :mutual_list,:intimate_friends,
                    :blacklist,:check,:match_nick_tips

        post_methods :add,:del,:addspecial,:delspecial,:addblacklist,:delblacklist

        def get_url_prefix
          @url_prefix
        end
      end

    end
  end
end
