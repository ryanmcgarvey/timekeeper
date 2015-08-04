class TableHelper < UxHelper

  def table
    find selector
  end

  def has_row?(text)
    row_with_text(text)
  end

  def row_with_text(text)
    within table do
      find 'tr', text: text
    end
  end
end
