#define DUNE_XT_COMMON_TEST_MAIN_CATCH_EXCEPTIONS 1

#include <dune/xt/common/test/main.hxx>

#include <dune/xt/common/exceptions.hh>
#include <dune/xt/grid/grids.hh>
#include <dune/xt/common/test/gtest/gtest.h>
#include <dune/geometry/quadraturerules.hh>
#include <dune/xt/grid/gridprovider/cube.hh>

#include <dune/xt/functions/spe10/model2.hh>

using namespace Dune::XT;

GTEST_TEST(DISABLED_spe10_model2_test, test_takes_too_long)
{
}

#if 0
{% for GRIDNAME, GRID, r, rC in config['types'] %}

struct Spe10Model2Function_from_{{GRIDNAME}}_to_{{r}}_times_{{rC}} : public ::testing::Test
{
  using GridType = {{GRID}};
  using ElementType = typename GridType::template Codim<0>::Entity;
  static const constexpr size_t d = GridType::dimension;
  static const size_t r = {{r}};
  static const size_t rC = {{rC}};

  using FunctionType = Functions::Spe10::Model2Function<ElementType, r, rC>;

  using DerivativeRangeType = typename FunctionType::LocalFunctionType::DerivativeRangeType;

  Spe10Model2Function_from_{{GRIDNAME}}_to_{{r}}_times_{{rC}}()
    : grid_(Dune::XT::Grid::make_cube_grid<GridType>({0, 0, 0},
                                                     {Dune::XT::Functions::Spe10::internal::model_2_length_x,
                                                      Dune::XT::Functions::Spe10::internal::model_2_length_y,
                                                      Dune::XT::Functions::Spe10::internal::model_2_length_z},
                                                     {Dune::XT::Functions::Spe10::internal::model2_x_elements,
                                                      Dune::XT::Functions::Spe10::internal::model2_y_elements,
                                                      Dune::XT::Functions::Spe10::internal::model2_z_elements}))
  {
    grid_.visualize("grid");
  }

  const Dune::XT::Grid::GridProvider<GridType> grid_;
};


TEST_F(Spe10Model2Function_from_{{GRIDNAME}}_to_{{r}}_times_{{rC}}, is_constructible)
{
  auto filename = Dune::XT::Functions::Spe10::internal::model2_filename;
  FunctionType function(filename,
                        {0, 0, 0},
                        {Dune::XT::Functions::Spe10::internal::model_2_length_x,
                         Dune::XT::Functions::Spe10::internal::model_2_length_y,
                         Dune::XT::Functions::Spe10::internal::model_2_length_z});
}

TEST_F(Spe10Model2Function_from_{{GRIDNAME}}_to_{{r}}_times_{{rC}}, has_default_config)
{
  auto cfg = FunctionType::default_config();
  EXPECT_EQ(cfg.get<std::string>("type"), FunctionType::static_id());
}

TEST_F(Spe10Model2Function_from_{{GRIDNAME}}_to_{{r}}_times_{{rC}}, is_creatable)
{
  auto default_function = FunctionType::create();

  const auto leaf_view = grid_.leaf_view();
  auto local_f = default_function->local_function();
  for (auto&& element : Dune::elements(leaf_view)) {
    local_f->bind(element);
    const auto actual_order = local_f->order();
    EXPECT_EQ(0, actual_order);
  }
}

TEST_F(Spe10Model2Function_from_{{GRIDNAME}}_to_{{r}}_times_{{rC}}, is_visualizable)
{
  auto default_function = FunctionType::create();
  const auto leaf_view = grid_.leaf_view();
  default_function->visualize(leaf_view, "test__Spe10Model2Function_from_{{GRIDNAME}}_to_{{r}}_times_{{rC}}__is_visualizable", /*subsampling=*/false);
}

TEST_F(Spe10Model2Function_from_{{GRIDNAME}}_to_{{r}}_times_{{rC}}, is_localizable)
{
  auto default_function = FunctionType::create();
  const auto leaf_view = grid_.leaf_view();
  for (auto&& element : Dune::elements(leaf_view)) {
    const auto local_f = default_function->local_function(element);
  }
}

TEST_F(Spe10Model2Function_from_{{GRIDNAME}}_to_{{r}}_times_{{rC}}, is_bindable)
{
  auto default_function = FunctionType::create();
  auto local_f = default_function->local_function();
  const auto leaf_view = grid_.leaf_view();
  for (auto&& element : Dune::elements(leaf_view)) {
    local_f->bind(element);
  }
}

TEST_F(Spe10Model2Function_from_{{GRIDNAME}}_to_{{r}}_times_{{rC}}, local_order)
{
  auto default_function = FunctionType::create();
  const auto leaf_view = grid_.leaf_view();
  const int expected_order = 0;
  auto local_f = default_function->local_function();
  for (auto&& element : Dune::elements(leaf_view)) {
    local_f->bind(element);
    const auto actual_order = local_f->order();
    EXPECT_EQ(expected_order, actual_order);
  }
}


TEST_F(Spe10Model2Function_from_{{GRIDNAME}}_to_{{r}}_times_{{rC}}, local_evaluate)
{
  const auto leaf_view = grid_.leaf_view();
  auto default_function = FunctionType::create();
  auto local_f = default_function->local_function();

  for (auto&& element : Dune::elements(leaf_view)) {
    local_f->bind(element);
    for (const auto& quadrature_point : Dune::QuadratureRules<double, d>::rule(element.type(), 3)) {
      const auto local_x = quadrature_point.position();
      const auto DUNE_UNUSED(actual_value) = local_f->evaluate(local_x);
    }
  }
}


TEST_F(Spe10Model2Function_from_{{GRIDNAME}}_to_{{r}}_times_{{rC}}, local_jacobian)
{
  const auto leaf_view = grid_.leaf_view();
  const DerivativeRangeType expected_jacobian = DerivativeRangeType();
  auto default_function = FunctionType::create();
  auto local_f = default_function->local_function();
  for (auto&& element : Dune::elements(leaf_view)) {
    local_f->bind(element);
    for (const auto& quadrature_point : Dune::QuadratureRules<double, d>::rule(element.type(), 3)) {
      const auto local_x = quadrature_point.position();
      const auto actual_jacobian = local_f->jacobian(local_x);
      EXPECT_EQ(expected_jacobian, actual_jacobian);
    }
  }
}

{% endfor  %}
#endif
