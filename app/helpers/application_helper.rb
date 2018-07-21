module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    #選択したcolumnにparamsで取得する:sortと:directionを追加する。
    link_to title, :sort => column, :direction => direction
  end

  def show_field_error(model, field)
    s= ""
    if !model.errors[field].empty?
      s =
      <<-EOHTML
      <div id="error_message">
        #{model.errors[field][0]}
      </div>
      EOHTML
    end
    s.html_safe
  end
  # 選択中のサイドメニューのクラスを返す
  def sidebar_activate(sidebar_link_url)
    current_url = request.headers['PATH_INFO']
    if current_url.match(sidebar_link_url)
      ' class="active"'
    else
      ''
    end
  end

  # サイドメニューの項目を出力する
  def sidebar_list_items
    items = [
      {:text => 'Users',      :path => tasks_path},
      #{:text => 'Contacts',   :path => contacts_path}
    ]

    html = ''
    items.each do |item|
      text = item[:text]
      path = item[:path]
      html = html + %Q(<li#{sidebar_activate(path)}><a href="#{path}">#{text}</a></li>)
    end

    raw(html)
  end

end
