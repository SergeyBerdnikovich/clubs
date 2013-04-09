ActiveAdmin.register Article do
  index do
    column :id
    column :title
    column (:description) { |article| article.description[0..50] }
    column ('autor') { |article| article.user.email if article.user }
    column :created_at
    column :updated_at

    default_actions
  end

  form do |f|
    f.inputs "Author" do
      f.input :user
    end
    f.inputs "Articles" do
      f.input :title
      f.input :description
      f.input :full_text, :input_html => {:class => "ckeditor"}
    end

    f.inputs "Categories" do
      f.has_many :articles_categories do |association|
        if !association.object.nil?
          association.input :_destroy, :as => :boolean, :label => "Destroy?"
          # link_to 'Delete', admin_articles_category_path(association, :delete => 'true'), :method => :delete
        end
        association.input :category
      end
   end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :description
      row :user
      row :categories do |article|
        div do
          article.categories.each do |category|
            ul
              li link_to category.name, admin_category_path(category)
          end
        end
      end
      row :created_at
      row :updated_at
      row (:full_text) { |article| raw(article.full_text) }
    end
    active_admin_comments
  end

  controller do
    def destroy

      destroy!
    end
  end
end
