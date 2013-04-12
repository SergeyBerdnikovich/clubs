ActiveAdmin.register Category do
  form do |f|
    f.inputs "Parent Category" do
      f.select(:parent_id, Category.all.collect {|p| [ p.name, p.id ] }, { :include_blank => true })
    end
    f.inputs "Category" do
      f.input :name
    end
    f.actions
  end
end
