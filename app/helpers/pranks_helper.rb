module PranksHelper
  def images_path(prank)
    prank_album_images_path(prank, prank.profile_album)
  end
  
  def add_tool_link(name)
    link_to_function name, :class => 'add-tool-link' do |page| 
  		page.insert_html :bottom, 'prank-tools', :partial => 'tools/tool_field', :object => Prank.new
  	end
  end
  
  def trunc_prank_text(prank, text, length=175)
    truncate(h(text), length, "... #{link_to('(more)', prank, :class => 'small-link')}")
  end
  
  def trunc_prank_instructions(prank, text, length=175)
    truncate(simple_format(sanitize(text)), length, "... #{link_to('(more)', prank, :class => 'small-link')}")
  end
end
