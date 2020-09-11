require 'selenium-webdriver'

class ScrapePenguin
  def initialize(fac,dpt,trm)
    @penguin = Selenium::WebDriver.for :firefox
    @fac = fac
    @dpt = dpt
    @trm = trm
  end

  def search
    @penguin.get('https://kyomu.adm.okayama-u.ac.jp/Portal/Public/Syllabus/SearchMain.aspx')
    faculty = @penguin.find_element(:name,'ctl00$phContents$ddl_fac')
    faculty.send_key(@fac);sleep 3

    department = @penguin.find_element(:name,'ctl00$phContents$ddl_dpt')
    department.send_keys(@dpt);sleep 3

    term = @penguin.find_element(:name,'ctl00$phContents$ddl_lctterm')
    term.send_keys(@trm);sleep 3

    submit = @penguin.find_element(:name,'ctl00$phContents$ctl18$btnSearch')
    submit.click;sleep 3
    
    lines = @penguin.find_element(:name,'ctl00$phContents$ucGrid$ddlLines')
    lines.send_keys('全件');sleep 3
    
    contents = @penguin.find_element(:id, 'ctl00_phContents_ucGrid_grv')
    @fish = contents.text

    @penguin.quit

  end

  def parse
    @fish = @fish.split("\n").map{|i| i.sub(/\[.*\]/,"").split}
    @fish.shift(1)
    @hashed_fish = []

    @fish.each do |e|
      next if e[-2] == 'その他'
      @hashed_fish << {class: e[4], date_and_time: e[-2]}
    end
  end

  def class_list
    @hashed_fish
  end
end
