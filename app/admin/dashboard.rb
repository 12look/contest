ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    works = Work.joins(:ratings).uniq
                .group('works.id')
                .having('count(distinct ratings.user_id) = ?', User.count_jury).count
    jury = Work.count
    json_data = []
    json_data << {
        label: 'Проголосованные работы',
        data: works.size
    }
    json_data << {
        label: 'Непроголосованные работы',
        data: jury
    }
    # works1.each do |key, value|
    #   json_data << {
    #       label: key,
    #       data: value
    #   }
    # end
    # jury.each do |key, value|
    #   json_data << {
    #       label: key,
    #       data: value
    #   }
    # end
      render partial: 'charts', locals: {
          works: json_data.to_json
      }

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
