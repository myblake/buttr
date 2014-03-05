class ListItemsController < ApplicationController
  def create
    @category = Category.find_or_create_by(name: params[:list_item][:category])
    @list_item = ListItem.create(params[:list_item].permit([:description, :list_id]).merge(category_id: @category.id))
    redirect_to controller: 'lists', action: 'show', id: @list_item.list.id
  end
  
end
