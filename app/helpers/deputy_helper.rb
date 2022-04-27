module DeputyHelper
  def set_issuance_date(issuance_date:, lang: 'pt')
    return 'Não Informado' unless issuance_date.present?
    case lang
    when 'pt'
      return issuance_date.strftime("%d/%m/%Y")
    when 'en'
      return issuance_date.strftime("%Y-%m-%d")
    else
      return 'Não Informado'
    end
  end

  def set_provider(provider:)
    provider.present? ? provider : 'Não Informado'
  end

  def set_document_url(document_url:)
    document_url.present? ? "<a href='#{document_url}' target='_blank' class='btn btn-sm btn-success'><i class='fa fa-download'></i></a>".html_safe : 'Não Informado'
  end
end
