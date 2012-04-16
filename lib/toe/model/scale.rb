# Scales create dimensions in space along which annotation objects can be aligned and oriented.
# The most common scale type is the timeline found in many transcription and annotation systems.
# But spatial and multidimensional scales are also possible.
# 
# == Creation
#
# Since scales typically are part of a document, the usual way to obtain a new scale object is
# to use a class method of {ToEDocument}:
#
#  ToEDocument.create_scale(params)
#
# You can also use the constructor although its use is not encouraged:
#
#  scale = Scale.new({:mode => :Nominal})
#
# However...

class ToE::Model::Scale < ToE::Model::BasicToEObject

  include BelongsToEventDocument
  
  @@MODES = [:Nominal, :Ordinal, :OrdinalCyclic, :Cardinal, :CardinalCyclic, :Ratio]

  
  public
  
  # The possible modes for a scale object. These correspond to the levels of measurement
  # first mentioney by Stevens (1946), in a variation that also includes cyclic scales,
  # that is, scales that have an order but no extreme values (for example, months or the
  # values on a clock display).
  def self.Modes
    @@MODES
  end
  
  # Checks whether the given object refers to a valid mode.
  # @param [Object] mode an object that somehow describes a mode.
  # @return [Mode] the corresponding mode symbol, or nil if nothing was found.
  def self.is_valid_mode?(mode)
    return mode if @@MODES.include? mode
    return nil
  end

  # Creates a new floating scale object.
  # @param [ToEDocument] document The ToE document this scale should belong to
  # @option params [MODE]    :mode  The scale mode to use. See {Scale.Modes} for a list of values.
  # @option params [String]  :unit  The unit of the scale (SI unit or a custom one).
  def initialize(document, params={})
    # super
    self.document = document
    # @todo adopt params
  end
  
  # Return the dimension of this scale.
  # @return [String] the dimension of this scale.
  def dimension
    @dimension
  end
  
  # Set a new dimension for this scale.
  # @param [Dimension] new_dimension
  # @return [void]
  def dimension=(new_dimension)
    @dimension = new_dimension
  end
  
  # Set a new scale set for this scale.
  # @param [ScaleSet] new_scale_set The new scale set for this scale.
  # @return [void]
  def scale_set=(new_scale_set)
    @scale_set = new_scale_set
  end
  
  # Return the scale set of this scale.
  # @return [scale_set] the scale set of this scale.
  def scale_set
    @scale_set
  end
  
  
  # Set a new mode for this scale.
  # The mode is also known as the level of measurement:
  # * nominal,
  # * ordinal,
  # * ordinal-cyclic,
  # * cardinal,
  # * cardinal-cyclic,
  # * ratio
  #
  # @param [mode] new_mode The new mode for this scale.
  # @return [void]
  def mode=(new_mode)
    @mode = new_mode
  end
  
  # Return the mode of this scale.
  # @see #mode=
  # @return [mode] the mode of this scale.
  def mode
    @mode
  end

  # Set a new unit for this scale.
  # @param [unit] new_unit
  # @return [void]
  def unit=(new_unit)
    @unit = new_unit
  end
  
  # Return the unit of this scale.
  # @return [unit] the unit of this scale.
  def unit
    @unit
  end

  # Set a new continuous for this scale.
  # @param [Boolean] new_continuous the new value for continuous
  # @return [void]
  def continuous=(new_continuous)
    @continuous = new_continuous
  end
  
  # Return the property of continuous of this scale.
  # @return [continuous] the continuous value of this scale.
  def continuous?
    @continuous
  end      
  
  # Set a new role for this scale.
  # @param [role] new_role
  # @return [void]
  def role=(new_role)
    @role = new_role
  end
  
  # Return the role of this scale.
  # @return [role] the role of this scale.
  def role
    @role
  end
  
  # return the scale elements, if possible (that is, if it is a finite set).
  def elements
    unless continuous?
      
    end
  end
  
  def inspect
    "Scale(##{id} #{mode}, #{dimension}, #{unit})"
  end
  
end