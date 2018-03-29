class Book
  def title=(names)
    exclusions = ['for', 'and', 'nor', 'but', 'or', 'yet', 'so', 'in', 'the', 'of', 'a', 'an']

    @title = names.split.map.with_index do |name,index|
      if index == 0 || !(exclusions.include? name)
        name.capitalize
      else
        name
      end
    end
  end

  def title
    @title.join(' ')
  end
end
