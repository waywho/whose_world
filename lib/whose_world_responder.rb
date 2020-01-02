module WhoseWorldResponder
  protected

  def json_resource_errors
    {
      success: false,
      errors: WhoseWorldErrorFormatter.call(resource.errors)
    }
  end
end