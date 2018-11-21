module TopCommentators
  class GetList < ServicesTemplate
    USERS_MAX = 10

    def perform!
      get_user_rankings_hash
      pull_users
      metaprogram_comments_number_to_users
      build_results_hash
      self
    end

    protected

      def get_user_rankings_hash
        # {user_id => number_of_comments, ...}
        @users_ranking_hash = Comment.where(comments: {created_at: time_window}).
          group('user_id').
          order('count_all DESC').
          limit(USERS_MAX).
          count
      end

      def pull_users
        @users = User.where(id: @users_ranking_hash.keys)
      end

      def metaprogram_comments_number_to_users
        User.send(:attr_accessor, :comments_number)
      end

      def build_results_hash
        @results = @users_ranking_hash.map do |user_id, comments_count|
          user = @users.detect{|u| u.id == user_id}
          user.comments_number = comments_count
          user
        end
      end

      def time_window
        7.days.ago.beginning_of_day..Time.now.end_of_day
      end
  end
end