object false
child(@countries => :countries) do
  attributes *country_attributes
end

if @countries.respond_to?(:num_pages)
  node(:count) { @countries.count }
  node(:current_page) { params[:page] || 1 }
  node(:pages) { @countries.num_pages }
end
