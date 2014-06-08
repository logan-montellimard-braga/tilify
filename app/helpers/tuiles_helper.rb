module TuilesHelper
  def getIconByType(tuile)
    case tuile.forme.downcase
    when 'image'
      return 'image'
    when 'tutoriel'
      return 'graduation-cap'
    when 'vidéo'
      return 'video-camera'
    when 'site'
      return 'bookmark'
    when 'forum'
      return 'comments'
    when 'documentation'
      return 'book'
    when 'autre'
      return 'ellipsis-h'
    else
      return 'ellipsis-h'
    end
  end
end
