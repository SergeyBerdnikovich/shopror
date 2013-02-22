# coding: utf-8
module ApplicationHelper

  ### The next three helpers are great to use to add and remove nested attributes in forms.
  #  LOK AT THIS WEBPAGE FOR REFERENCE
  ## http://openmonkey.com/articles/2009/10/complex-nested-forms-with-rails-unobtrusive-jquery
=begin
EXAMPLE USAGE!!
  <% form.fields_for :properties do |property_form| %>
    <%= render :partial => '/admin/merchandise/add_property', :locals => { :f => property_form } %>
  <% end %>
  <p><%= add_child_link "New Property", :properties %></p>
  <%= new_child_fields_template(form, :properties, :partial => '/admin/merchandise/add_property')%>
=end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  def site_name
    I18n.t(:company)
  end

  def remove_child_link(name, f)
    f.hidden_field(:_destroy) + link_to(name, "javascript:void(0)", :class => "remove_child")
  end

  def add_child_link(name, association)
    link_to(name, "javascript:void(0);", :class => "add_child", :"data-association" => association)
  end

  def add_child_button(name, association)
    link_to(name, "javascript:void(0);", :class => "add_child button", :"data-association" => association)
  end

  def new_child_fields_template(form_builder, association, options = {})
    options[:object] ||= form_builder.object.class.reflect_on_association(association).klass.new
    options[:partial] ||= association.to_s.singularize
    options[:locals] ||= {}
    options[:form_builder_local] ||= :f

    content_tag(:div, :id => "#{association}_fields_template", :style => "display: none") do
      form_builder.fields_for(association, options[:object], :child_index => "new_#{association}") do |f|
        raw( render(:partial => options[:partial], :locals => {options[:form_builder_local] => f }.merge(options[:locals])) )
      end
    end
  end

  def child_product_types_for(product_type)
    html = ""
    html << "<ul>"
    ProductType.for_parent_of(product_type).each do |pr_type_lvl_2|
      product_types_lvl3 = ProductType.for_parent_of(pr_type_lvl_2)
      html << "<li><a href='/products?product_type_id=#{pr_type_lvl_2.id}' class=#{'fly' unless product_types_lvl3.blank?}>#{pr_type_lvl_2.name}</a>"
      unless product_types_lvl3.blank?
        html << "<ul>"
        product_types_lvl3.each do |pr_type_lvl_3|
          html << "<li><a href='/products?product_type_id=#{pr_type_lvl_3.id}'>#{pr_type_lvl_3.name}</a></li>"
        end
        html << "</ul>"
      end
      html << "</li>"
    end
    html << "</ul>"
    html
  end

  def facebook_like
    content_tag :iframe, nil, :src => "http://www.facebook.com/plugins/like.php?href=#{CGI::escape(request.url)}&layout=standard&show_faces=true&width=450&action=like&font=arial&colorscheme=light&height=80", :scrolling => 'no', :frameborder => '0', :allowtransparency => true, :id => :facebook_like
  end
end
