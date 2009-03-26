class AddPrankTestData < ActiveRecord::Migration
  def self.up
    Prank.delete_all
    Prank.create(:title => 'Penny Up a Door',
      :summary => 'Lock someone in their room from the outside by only using pennies.',
      :tools => 'A few pennies',
      :targets => 'Anyone inside a room with the door closed',
      :instructions => 
      %{<p>Pennying a door is done from the outside to lock someone in their own room. It is done by jamming pennies into the hinge side of the door (away from tbe knob and where it normally opens). The theory is that the pennies prevent the door from pivoting through the small space as it tries to open, thus preventing the motion from working.</p>
        <p>While it can work on the right door, it doesn't work very well. Your best chance is making sure the pennies are pushed in as far as possible to get to the pivot point, otherwise the door will pivot and just push the pennies back out.
      </p>})
      
    Prank.create(:title => 'Upper Deck',
      :summary => 'Cause victim\'s toilet to produce dirty water on every flush',
      :tools => 'Bowl movement',
      :targets => 'Anyone who owns a toilet',
      :instructions => 
      %{<p>Release bowls into the top tank of your victim's toilet. Leave. After your creation has stewed for a few hours, the victim's toilet should be good to go.</p>})
      
    Prank.create(:title => 'Ambidextrous Mouse',
      :summary => 'Switch the button functions on your victim\'s mouse',
      :tools => 'None',
      :targets => 'Anyone with a computer',
      :instructions => 
      %{<p>Go to the Windows Control Panel and double-click "Mouse." Switch the right mouse button so that it's activated by the left mouse button, and vice-versa. For even more fun, make the mouse go as slowly as you can, then laugh as it takes them forever to switch it back.</p>})
  end

  def self.down
  end
end
