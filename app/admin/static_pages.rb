ActiveAdmin.register StaticPage do
  form do |f|
    f.inputs do
      f.input :title
      f.input :content, :input_html => {:class => "ckeditor"}
    end
    f.buttons
  end

  show do
    attributes_table do
      row :id
      row :title
      row :created_at
      row :updated_at
      row (:content) { |page| raw(page.content) }
    end
    active_admin_comments
  end

  index do
    column :id
    column :title
    column (:content) { |page| raw(page.content[0..200]) }
    column :created_at
    column :updated_at

    default_actions
  end
end
