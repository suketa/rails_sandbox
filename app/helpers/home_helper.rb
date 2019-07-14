module HomeHelper
  def word_wrap_message
    msg = <<~MSG
        This is a multiline message.
        This is a second line of second paragraph. This is a second line part 2
      of second paragraph.
        This is a third paragraph. This line is a part 2 of third paragraph.
    MSG
    word_wrap(msg, line_width: 40)
  end
end
