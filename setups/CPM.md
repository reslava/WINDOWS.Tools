# Central Package Management ([CPM](https://learn.microsoft.com/en-us/nuget/consume-packages/central-package-management))


## What is CPM?
Central Package Management (CPM) is a feature in NuGet that allows you to manage package versions for all projects in a solution from a single file. This file is called `Directory.Packages.props` and is located in the root of the solution.

## How to use CPM?
1. To get started with Central Package Management, create a Directory.Packages.props file at the root of your repository and set the MSBuild property ManagePackageVersionsCentrally to true.

You can create it manually, or use the .NET CLI:
```shell
dotnet new packagesprops
```
2. Inside Directory.Packages.props, define <PackageVersion /> elements to specify the package IDs and versions used by your projects.:
```xml
<Project>
  <PropertyGroup>
    <ManagePackageVersionsCentrally>true</ManagePackageVersionsCentrally>
  </PropertyGroup>
  <ItemGroup>
    <PackageVersion Include="Package1" Version="1.0.0" />
    <PackageVersion Include="Pachage2" Version="2.0.0" />
  </ItemGroup>
</Project>
```
3. In each project file, define <PackageReference /> elements without the Version attribute. The version will be resolved from the corresponding <PackageVersion /> entry in Directory.Packages.props. file.
```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>net10.0</TargetFramework>
  </PropertyGroup>
  <ItemGroup>
    <PackageReference Include="Package2" />
  </ItemGroup>
</Project>
```
4. Add the `Directory.Packages.props` file to the solution.
5. Build the solution.  