// This file is part of the dune-stuff project:
//   https://github.com/wwu-numerik/dune-stuff
// Copyright holders: Rene Milk, Felix Schindler
// License: BSD 2-Clause License (http://opensource.org/licenses/BSD-2-Clause)

#ifndef DUNE_STUFF_FUNCTIONS_VISUALIZATION_HH
#define DUNE_STUFF_FUNCTIONS_VISUALIZATION_HH

#if HAVE_DUNE_GRID
#include <dune/grid/io/file/vtk/function.hh>
#endif

#include <dune/stuff/common/float_cmp.hh>

#include "interfaces.hh"

namespace Dune {
namespace Stuff {
namespace Functions {

#if HAVE_DUNE_GRID


template <class GridViewType, int dimRange, int dimRangeCols>
class VisualizationAdapter : public VTKFunction<GridViewType>
{
public:
  typedef typename GridViewType::template Codim<0>::Entity EntityType;

  typedef typename GridViewType::ctype DomainFieldType;
  static const unsigned int dimDomain = GridViewType::dimension;
  typedef FieldVector<DomainFieldType, dimDomain> DomainType;

  typedef LocalizableFunctionInterface<EntityType, DomainFieldType, dimDomain, double, dimRange, dimRangeCols>
      FunctionType;

  VisualizationAdapter(const FunctionType& function, const std::string nm = "")
    : function_(function)
    , tmp_value_(0)
    , name_(nm)
  {
  }

private:
  template <int r, int rC, bool anything = true>
  class Call
  {
  public:
    static int ncomps()
    {
      return 1;
    }

    static double evaluate(const int& /*comp*/, const typename FunctionType::RangeType& val)
    {
      return val.frobenius_norm();
    }
  }; // class Call

  template <int r, bool anything>
  class Call<r, 1, anything>
  {
  public:
    static int ncomps()
    {
      return r;
    }

    static double evaluate(const int& comp, const typename FunctionType::RangeType& val)
    {
      return val[comp];
    }
  }; // class Call< ..., 1, ... >

public:
  virtual int ncomps() const override final
  {
    return Call<dimRange, dimRangeCols>::ncomps();
  }

  virtual std::string name() const override final
  {
    if (name_.empty())
      return function_.name();
    else
      return name_;
  }

  virtual double evaluate(int comp, const EntityType& en, const DomainType& xx) const override final
  {
    assert(comp >= 0);
    assert(comp < dimRange);
    const auto local_func = function_.local_function(en);
    local_func->evaluate(xx, tmp_value_);
    return Call<dimRange, dimRangeCols>::evaluate(comp, tmp_value_);
  }

private:
  const FunctionType& function_;
  mutable typename FunctionType::RangeType tmp_value_;
  const std::string name_;
}; // class VisualizationAdapter


#endif // HAVE_DUNE_GRID

} // namespace Functions
} // namespace Stuff
} // namespace Dune

#endif // DUNE_STUFF_FUNCTIONS_VISUALIZATION_HH
