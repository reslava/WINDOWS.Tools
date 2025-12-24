# Central Package Management ([CPM](https://learn.microsoft.com/en-us/nuget/consume-packages/central-package-management))


## What is CPM?
Central Package Management (CPM) is a feature in NuGet that allows you to manage package versions for all projects in a solution from a single file. This file is called `Directory.Packages.props` and is located in the root of the solution.

## How to use CPM?
1. Create a `Directory.Packages.props` file in the root of the solution.
2. Add the following content to the file:
```xml
<Project>
  <PropertyGroup>
    <ManagePackageVersionsCentrally>true</ManagePackageVersionsCentrally>
  </PropertyGroup>
  <ItemGroup>
    <PackageVersion Include="Microsoft.Extensions.Logging" Version="7.0.0" />
    <PackageVersion Include="Microsoft.Extensions.Logging.Abstractions" Version="7.0.0" />
    <PackageVersion Include="Microsoft.Extensions.Logging.Console" Version="7.0.0" />
  </ItemGroup>
</Project>
```
3. Add the `Directory.Packages.props` file to the solution.
4. Build the solution.

## How to add a new package?
1. Add the package to the `Directory.Packages.props` file.
2. Add the package to the