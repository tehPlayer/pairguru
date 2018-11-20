class TitleBracketsValidator < ActiveModel::Validator
  OPENING_BRACKETS = ['(', '[', '{']
  CLOSING_BRACKETS = [')', ']', '}']

  BRACKETS_MATCH = CLOSING_BRACKETS.zip(OPENING_BRACKETS).to_h

  def validate(record)
    @brackets_array = [] # reset array before every validation call
    @empty_bracket = false
    record.errors.add(:title, :invalid) unless title_valid?(record.title)
  end

  private

    def title_valid?(title)
      title.each_char do |title_char|
        if opening_bracket?(title_char)
          add_opening_bracket(title_char)
        elsif closing_bracket?(title_char)
          return false if brackets_empty? || !closing_bracket_matches?(title_char)
          remove_matching_brackets
        else
          @empty_bracket = false
        end
      end
      all_brackets_closed?
    end

    def opening_bracket?(bracket_char)
      OPENING_BRACKETS.include?(bracket_char)
    end

    def closing_bracket?(bracket_char)
      CLOSING_BRACKETS.include?(bracket_char)
    end

    def add_opening_bracket(bracket_char)
      @brackets_array << bracket_char
      @empty_bracket = true
    end

    def brackets_empty?
      @empty_bracket
    end

    def closing_bracket_matches?(bracket_char)
      @brackets_array.last == BRACKETS_MATCH[bracket_char]
    end

    def remove_matching_brackets
      @brackets_array.pop
    end

    def all_brackets_closed?
      @brackets_array.empty?
    end
end