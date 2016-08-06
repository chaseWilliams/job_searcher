class String
  def html_fix
    begin
      while self.index('<') != nil
        if self.index('>') != nil
          self.slice! (self.index('<')..self.index('>'))
        end
      end
    rescue StandardError
      return self
    end
    return self
  end
  def contains(pattern)
    !(self.index(pattern).nil?)
  end
end