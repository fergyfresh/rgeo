# -----------------------------------------------------------------------------
#
# Tests for mixin system
#
# -----------------------------------------------------------------------------

require "test_helper"

class MixinsTest < Test::Unit::TestCase # :nodoc:
  module Mixin1  # :nodoc:
    def mixin1_method
    end
  end

  module Mixin2  # :nodoc:
    def mixin2_method
    end
  end

  RGeo::Feature::MixinCollection::GLOBAL.for_type(RGeo::Feature::Point).add(Mixin1)
  RGeo::Feature::MixinCollection::GLOBAL.for_type(RGeo::Feature::GeometryCollection).add(Mixin1)
  RGeo::Feature::MixinCollection::GLOBAL.for_type(RGeo::Feature::MultiCurve).add(Mixin2)

  def test_basic_mixin_cartesian
    factory = RGeo::Cartesian.simple_factory
    assert_equal(RGeo::Cartesian::PointImpl, factory.point(1, 1).class)
    assert(factory.point(1, 1).class.include?(Mixin1))
    assert(!factory.point(1, 1).class.include?(Mixin2))
    assert(factory.point(1, 1).respond_to?(:mixin1_method))
    assert(!factory.point(1, 1).respond_to?(:mixin2_method))
  end

  def test_inherited_mixin_cartesian
    factory = RGeo::Cartesian.simple_factory
    assert(factory.collection([]).class.include?(Mixin1))
    assert(!factory.collection([]).class.include?(Mixin2))
    assert(factory.collection([]).respond_to?(:mixin1_method))
    assert(!factory.collection([]).respond_to?(:mixin2_method))
    assert(factory.multi_line_string([]).class.include?(Mixin1))
    assert(factory.multi_line_string([]).class.include?(Mixin2))
    assert(factory.multi_line_string([]).respond_to?(:mixin1_method))
    assert(factory.multi_line_string([]).respond_to?(:mixin2_method))
  end

  if RGeo::Geos.capi_supported?

    def test_basic_mixin_geos_capi
      factory = RGeo::Geos.factory(native_interface: :capi)
      assert_equal(RGeo::Geos::CAPIPointImpl, factory.point(1, 1).class)
      assert(factory.point(1, 1).class.include?(Mixin1))
      assert(!factory.point(1, 1).class.include?(Mixin2))
      assert(factory.point(1, 1).respond_to?(:mixin1_method))
      assert(!factory.point(1, 1).respond_to?(:mixin2_method))
    end

    def test_inherited_mixin_geos_capi
      factory = RGeo::Geos.factory(native_interface: :capi)
      assert(factory.collection([]).class.include?(Mixin1))
      assert(!factory.collection([]).class.include?(Mixin2))
      assert(factory.collection([]).respond_to?(:mixin1_method))
      assert(!factory.collection([]).respond_to?(:mixin2_method))
      assert(factory.multi_line_string([]).class.include?(Mixin1))
      assert(factory.multi_line_string([]).class.include?(Mixin2))
      assert(factory.multi_line_string([]).respond_to?(:mixin1_method))
      assert(factory.multi_line_string([]).respond_to?(:mixin2_method))
    end

  end

  if RGeo::Geos.ffi_supported?

    def test_basic_mixin_geos_ffi
      factory = RGeo::Geos.factory(native_interface: :ffi)
      assert_equal(RGeo::Geos::FFIPointImpl, factory.point(1, 1).class)
      assert(factory.point(1, 1).class.include?(Mixin1))
      assert(!factory.point(1, 1).class.include?(Mixin2))
      assert(factory.point(1, 1).respond_to?(:mixin1_method))
      assert(!factory.point(1, 1).respond_to?(:mixin2_method))
    end

    def test_inherited_mixin_geos_ffi
      factory = RGeo::Geos.factory(native_interface: :ffi)
      assert(factory.collection([]).class.include?(Mixin1))
      assert(!factory.collection([]).class.include?(Mixin2))
      assert(factory.collection([]).respond_to?(:mixin1_method))
      assert(!factory.collection([]).respond_to?(:mixin2_method))
      assert(factory.multi_line_string([]).class.include?(Mixin1))
      assert(factory.multi_line_string([]).class.include?(Mixin2))
      assert(factory.multi_line_string([]).respond_to?(:mixin1_method))
      assert(factory.multi_line_string([]).respond_to?(:mixin2_method))
    end

  end

  def test_basic_mixin_spherical
    factory = RGeo::Geographic.spherical_factory
    assert_equal(RGeo::Geographic::SphericalPointImpl, factory.point(1, 1).class)
    assert(factory.point(1, 1).class.include?(Mixin1))
    assert(!factory.point(1, 1).class.include?(Mixin2))
    assert(factory.point(1, 1).respond_to?(:mixin1_method))
    assert(!factory.point(1, 1).respond_to?(:mixin2_method))
  end

  def test_inherited_mixin_spherical
    factory = RGeo::Geographic.spherical_factory
    assert(factory.collection([]).class.include?(Mixin1))
    assert(!factory.collection([]).class.include?(Mixin2))
    assert(factory.collection([]).respond_to?(:mixin1_method))
    assert(!factory.collection([]).respond_to?(:mixin2_method))
    assert(factory.multi_line_string([]).class.include?(Mixin1))
    assert(factory.multi_line_string([]).class.include?(Mixin2))
    assert(factory.multi_line_string([]).respond_to?(:mixin1_method))
    assert(factory.multi_line_string([]).respond_to?(:mixin2_method))
  end

  def test_basic_mixin_simple_mercator
    factory = RGeo::Geographic.simple_mercator_factory
    assert_equal(RGeo::Geographic::ProjectedPointImpl, factory.point(1, 1).class)
    assert(factory.point(1, 1).class.include?(Mixin1))
    assert(!factory.point(1, 1).class.include?(Mixin2))
    assert(factory.point(1, 1).respond_to?(:mixin1_method))
    assert(!factory.point(1, 1).respond_to?(:mixin2_method))
  end

  def test_inherited_mixin_simple_mercator
    factory = RGeo::Geographic.simple_mercator_factory
    assert(factory.collection([]).class.include?(Mixin1))
    assert(!factory.collection([]).class.include?(Mixin2))
    assert(factory.collection([]).respond_to?(:mixin1_method))
    assert(!factory.collection([]).respond_to?(:mixin2_method))
    assert(factory.multi_line_string([]).class.include?(Mixin1))
    assert(factory.multi_line_string([]).class.include?(Mixin2))
    assert(factory.multi_line_string([]).respond_to?(:mixin1_method))
    assert(factory.multi_line_string([]).respond_to?(:mixin2_method))
  end
end
