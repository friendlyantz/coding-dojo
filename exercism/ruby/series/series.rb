class SliceLengthError < ArgumentError
  def initialize(message = 'Slice size can not exceed sample length')
    super
  end
end

class InvalidInputError < ArgumentError
  def initialize(message = 'A collection must be used')
    super
  end
end

class Series
  private

  attr_writer :collection

  def initialize(*collection)
    collection = collection.first if collection.size == 1
    @collection =
      case collection
      in String then collection.chars
      in Integer then collection.digits.reverse
      in _ if _.respond_to?(:index) then collection
      else raise InvalidInputError
      end
  end

  public

  attr_reader :collection

  def slices(slice_size)
    slice_size.positive? or raise SliceLengthError, 'must be positive'
    slice_size <= collection.size or raise SliceLengthError

    collection
      .each_cons(slice_size)
      .map(&:join)
  end
end
