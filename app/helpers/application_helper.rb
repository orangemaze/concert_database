module ApplicationHelper

  def fix_bad_dates_in_db(bad_date)
    # good_date = bad_date
    case bad_date.to_s
      when /(\d{4})-(\d{2})-(\d{2})/
        good_date = bad_date.to_s
      when /xxxx-xx-xx/
        good_date = (bad_date.to_s.gsub('xxxx-xx-xx', '9999-01-01')).to_s
      when /xxxx - xxxx/
        good_date = (bad_date.to_s.gsub('xxxx - xxxx', '9999-01-01')).to_s
      when /(\d{3})x-xx-xx/
        good_date = (bad_date.to_s.gsub('x-xx-xx', '0-01-01')).to_s
      when /(\d{4})-xx-xx/
        good_date = (bad_date.to_s.gsub('-xx-xx', '-01-01')).to_s
      when /(\d{4})-(\d{2})/
        good_date = (bad_date.to_s + '-01').to_s
      when /(\d{4})/
        good_date = (bad_date.to_s + '-01-01').to_s
      when /(\d{4})-00-00/
        good_date = (bad_date.to_s.gsub('-00-00', '-01-01')).to_s
      else
        good_date = '<span style="color:red;font-size:20pt;">' +  bad_date.to_s + '</span>'
    end
  end

end
