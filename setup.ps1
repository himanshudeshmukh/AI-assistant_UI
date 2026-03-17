# Authenticator - Automated Setup Script
# PowerShell script to create complete folder structure and files
# Run this in your authenticator project root directory

# ============================================================================
# Color output for PowerShell
# ============================================================================

function Write-Success {
    param([string]$Message)
    Write-Host "✅ $Message" -ForegroundColor Green
}

function Write-Error-Custom {
    param([string]$Message)
    Write-Host "❌ $Message" -ForegroundColor Red
}

function Write-Info {
    param([string]$Message)
    Write-Host "ℹ️  $Message" -ForegroundColor Cyan
}

function Write-Title {
    param([string]$Message)
    Write-Host "`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
    Write-Host "  $Message" -ForegroundColor Yellow
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
}

# ============================================================================
# MAIN SETUP
# ============================================================================

Write-Title "AUTHENTICATOR - AUTOMATED SETUP"

# Check if we're in the right directory
if (!(Test-Path "pubspec.yaml")) {
    Write-Error-Custom "pubspec.yaml not found! Are you in the authenticator directory?"
    Write-Info "Run this script from your authenticator project root"
    exit 1
}

Write-Info "Starting setup in: $(Get-Location)"

# ============================================================================
# STEP 1: Create Config Folders
# ============================================================================

Write-Title "STEP 1: Creating Config Folders"

$configFolders = @(
    "lib\config\theme",
    "lib\config\constants"
)

foreach ($folder in $configFolders) {
    if (-not (Test-Path $folder)) {
        New-Item -ItemType Directory -Force -Path $folder | Out-Null
        Write-Success "Created $folder"
    } else {
        Write-Info "Already exists: $folder"
    }
}

# ============================================================================
# STEP 2: Create Core Folders
# ============================================================================

Write-Title "STEP 2: Creating Core Folders"

$coreFolders = @(
    "lib\core\models",
    "lib\core\network",
    "lib\core\validators"
)

foreach ($folder in $coreFolders) {
    if (-not (Test-Path $folder)) {
        New-Item -ItemType Directory -Force -Path $folder | Out-Null
        Write-Success "Created $folder"
    } else {
        Write-Info "Already exists: $folder"
    }
}

# ============================================================================
# STEP 3: Create Data Folders
# ============================================================================

Write-Title "STEP 3: Creating Data Folders"

$dataFolders = @(
    "lib\data\repositories"
)

foreach ($folder in $dataFolders) {
    if (-not (Test-Path $folder)) {
        New-Item -ItemType Directory -Force -Path $folder | Out-Null
        Write-Success "Created $folder"
    } else {
        Write-Info "Already exists: $folder"
    }
}

# ============================================================================
# STEP 4: Create Presentation Folders
# ============================================================================

Write-Title "STEP 4: Creating Presentation Folders"

$presentationFolders = @(
    "lib\presentation\providers",
    "lib\presentation\screens\splash",
    "lib\presentation\screens\landing",
    "lib\presentation\screens\auth",
    "lib\presentation\screens\home",
    "lib\presentation\widgets"
)

foreach ($folder in $presentationFolders) {
    if (-not (Test-Path $folder)) {
        New-Item -ItemType Directory -Force -Path $folder | Out-Null
        Write-Success "Created $folder"
    } else {
        Write-Info "Already exists: $folder"
    }
}

# ============================================================================
# STEP 5: Create Utils Folders
# ============================================================================

Write-Title "STEP 5: Creating Utils Folders"

if (-not (Test-Path "lib\utils")) {
    New-Item -ItemType Directory -Force -Path "lib\utils" | Out-Null
    Write-Success "Created lib\utils"
} else {
    Write-Info "Already exists: lib\utils"
}

# ============================================================================
# STEP 6: Create Assets Folders
# ============================================================================

Write-Title "STEP 6: Creating Assets Folders"

$assetsFolders = @(
    "assets\images\icons",
    "assets\images\illustrations",
    "assets\fonts\Poppins",
    "assets\fonts\Inter"
)

foreach ($folder in $assetsFolders) {
    if (-not (Test-Path $folder)) {
        New-Item -ItemType Directory -Force -Path $folder | Out-Null
        Write-Success "Created $folder"
    } else {
        Write-Info "Already exists: $folder"
    }
}

# ============================================================================
# STEP 7: Create Dart Files - Config
# ============================================================================

Write-Title "STEP 7: Creating Config Dart Files"

$configFiles = @(
    "lib\config\theme\app_colors.dart",
    "lib\config\theme\app_text_styles.dart",
    "lib\config\theme\app_theme.dart",
    "lib\config\constants\app_constants.dart",
    "lib\config\constants\strings.dart"
)

foreach ($file in $configFiles) {
    if (-not (Test-Path $file)) {
        New-Item -ItemType File -Force -Path $file | Out-Null
        Write-Success "Created $file"
    } else {
        Write-Info "Already exists: $file"
    }
}

# ============================================================================
# STEP 8: Create Dart Files - Core
# ============================================================================

Write-Title "STEP 8: Creating Core Dart Files"

$coreFiles = @(
    "lib\core\models\auth_models.dart",
    "lib\core\network\api_client.dart",
    "lib\core\validators\validators.dart"
)

foreach ($file in $coreFiles) {
    if (-not (Test-Path $file)) {
        New-Item -ItemType File -Force -Path $file | Out-Null
        Write-Success "Created $file"
    } else {
        Write-Info "Already exists: $file"
    }
}

# ============================================================================
# STEP 9: Create Dart Files - Data
# ============================================================================

Write-Title "STEP 9: Creating Data Dart Files"

$dataFiles = @(
    "lib\data\repositories\auth_repository.dart"
)

foreach ($file in $dataFiles) {
    if (-not (Test-Path $file)) {
        New-Item -ItemType File -Force -Path $file | Out-Null
        Write-Success "Created $file"
    } else {
        Write-Info "Already exists: $file"
    }
}

# ============================================================================
# STEP 10: Create Dart Files - Presentation
# ============================================================================

Write-Title "STEP 10: Creating Presentation Dart Files"

$presentationFiles = @(
    "lib\presentation\providers\auth_provider.dart",
    "lib\presentation\screens\splash\splash_screen.dart",
    "lib\presentation\screens\landing\landing_screen.dart",
    "lib\presentation\screens\auth\login_screen.dart",
    "lib\presentation\screens\auth\signup_screen.dart",
    "lib\presentation\screens\home\home_screen.dart",
    "lib\presentation\widgets\auth_widgets.dart",
    "lib\presentation\widgets\common_widgets.dart",
    "lib\presentation\widgets\buttons.dart"
)

foreach ($file in $presentationFiles) {
    if (-not (Test-Path $file)) {
        New-Item -ItemType File -Force -Path $file | Out-Null
        Write-Success "Created $file"
    } else {
        Write-Info "Already exists: $file"
    }
}

# ============================================================================
# STEP 11: Create Dart Files - Utils
# ============================================================================

Write-Title "STEP 11: Creating Utils Dart Files"

$utilsFiles = @(
    "lib\utils\extensions.dart",
    "lib\utils\logger.dart"
)

foreach ($file in $utilsFiles) {
    if (-not (Test-Path $file)) {
        New-Item -ItemType File -Force -Path $file | Out-Null
        Write-Success "Created $file"
    } else {
        Write-Info "Already exists: $file"
    }
}

# ============================================================================
# STEP 12: Summary
# ============================================================================

Write-Title "SETUP COMPLETE! ✨"

Write-Host @"

📁 Folder Structure Summary:
  ✅ Config folders (theme, constants)
  ✅ Core folders (models, network, validators)
  ✅ Data folders (repositories)
  ✅ Presentation folders (screens, widgets, providers)
  ✅ Utils folders
  ✅ Assets folders (images, fonts)

📄 Files Created:
  ✅ 5 Config files
  ✅ 3 Core files
  ✅ 1 Data file
  ✅ 9 Presentation files
  ✅ 2 Utils files

🎯 Next Steps:

  1. Download files from outputs folder
  2. Copy file contents to corresponding Dart files
  3. Update pubspec.yaml with provided version
  4. Run: flutter pub get
  5. Run: flutter run

📚 Documentation:
  - AUTHENTICATOR_SETUP_GUIDE.md (Complete setup guide)
  - AUTHENTICATOR_COMPLETE_INDEX.md (File reference)
  - FOLDER_STRUCTURE.md (Folder layout)

🎨 Theme Details:
  - Primary Color: Golden Yellow (#FFB81C)
  - Secondary Color: Orange (#FF8C00)
  - Complete typography system
  - Material Design 3 implementation

Happy coding! 🚀

" -ForegroundColor Green

Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Yellow
