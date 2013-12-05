module UserHelper
  def first_name(full_name)
    full_name.split(" ",2).first
  end

  def last_name(full_name)
    full_name.split(" ",2).last
  end

end
