{ lib
, boto3
, buildPythonPackage
, pythonOlder
, typing-extensions
, fetchPypi
}:
let
  toUnderscore = str: builtins.replaceStrings [ "-" ] [ "_" ] str;

  buildMypyBoto3Package = serviceName: version: hash:
    buildPythonPackage rec {
      pname = "mypy-boto3-${serviceName}";
      inherit version;
      format = "setuptools";

      disabled = pythonOlder "3.7";

      src = fetchPypi {
        inherit pname version hash;
      };

      propagatedBuildInputs = [
        boto3
      ] ++ lib.optionals (pythonOlder "3.12") [
        typing-extensions
      ];

      # Project has no tests
      doCheck = false;

      pythonImportsCheck = [
        "mypy_boto3_${toUnderscore serviceName}"
      ];

      meta = with lib; {
        description = "Type annotations for boto3 ${serviceName}";
        homepage = "https://github.com/youtype/mypy_boto3_builder";
        license = with licenses; [ mit ];
        maintainers = with maintainers; [ fab mbalatsko ];
      };
    };
in
rec {
  mypy-boto3-accessanalyzer = buildMypyBoto3Package "accessanalyzer" "1.28.36" "sha256-1gfL7x81tTVZlYL8UwoI5k8pDotu1byCWqP31CruRIo=";

  mypy-boto3-account = buildMypyBoto3Package "account" "1.28.36" "sha256-RDGy7V+YgVlGufL+bFJ1xR5yi4xc2zkV+gTBdXdwkxk=";

  mypy-boto3-acm = buildMypyBoto3Package "acm" "1.28.37" "sha256-NDYWiS7MM7z6mCpRASWh42IGsSTUvVzIJU0eH5V7JUI=";

  mypy-boto3-acm-pca = buildMypyBoto3Package "acm-pca" "1.28.37" "sha256-l79J8dndeHBZTdXhYCUSa39lYFgcgM6/lIUQPx4HbRE=";

  mypy-boto3-alexaforbusiness = buildMypyBoto3Package "alexaforbusiness" "1.28.37" "sha256-Rk2BLp1oqwOG+Rd9lal53RArPjIo1XMkmXhZJLiI6Ik=";

  mypy-boto3-amp = buildMypyBoto3Package "amp" "1.28.36" "sha256-/iFfYQ2hwndbtOPnFx5GopCNOYi4uAAOTbD8Z8xFOoE=";

  mypy-boto3-amplify = buildMypyBoto3Package "amplify" "1.28.36" "sha256-ORwKl4j3M+O9a/JVrfal2lCBOe8QEcjAWscEhRqPrxc=";

  mypy-boto3-amplifybackend = buildMypyBoto3Package "amplifybackend" "1.28.36" "sha256-tx837SLt7DL1bD/bZl0egzVpClfJKaSY6p82yrcHWRQ=";

  mypy-boto3-amplifyuibuilder = buildMypyBoto3Package "amplifyuibuilder" "1.28.54" "sha256-5Y2AacuMzVHdPntUyDts21bUzttM9t8EdBcwV1MHhyU=";

  mypy-boto3-apigateway = buildMypyBoto3Package "apigateway" "1.28.36" "sha256-5GDltAso++KS+EKZPnvzrVFNAHN3SzDxxeE33mq6xoE=";

  mypy-boto3-apigatewaymanagementapi = buildMypyBoto3Package "apigatewaymanagementapi" "1.28.36" "sha256-yh5Xd7rKl6eUZBvnqgVU3BEThbIoVOWA15UEYoFicLo=";

  mypy-boto3-apigatewayv2 = buildMypyBoto3Package "apigatewayv2" "1.28.36" "sha256-ZSj0PoLQaUtqd0qLzU+Eg3YG0q6GwWEitKZCTfYergI=";

  mypy-boto3-appconfig = buildMypyBoto3Package "appconfig" "1.28.52" "sha256-OjHFaTlMso7dbUCyNfOtbIgpRQYmVm7n0PoUZjOaf18=";

  mypy-boto3-appconfigdata = buildMypyBoto3Package "appconfigdata" "1.28.36" "sha256-dGBUpgH/1QQ3nGxhkLWBW06ngmr+Iq2v9MqjrZ0vP1k=";

  mypy-boto3-appfabric = buildMypyBoto3Package "appfabric" "1.28.36" "sha256-WN7nEPs2KweoGu7XUycFpp8i/bOWSlcr+6BZFSFh6KM=";

  mypy-boto3-appflow = buildMypyBoto3Package "appflow" "1.28.42" "sha256-zUqO8SGKoA9umP2iKrw5VXC4pBBVqs4D9Ou/lJwEVBI=";

  mypy-boto3-appintegrations = buildMypyBoto3Package "appintegrations" "1.28.55" "sha256-Sii5aQ9Y1YvpW1QLMXOeboLXzSR7RCZA6hDGvI39yWM=";

  mypy-boto3-application-autoscaling = buildMypyBoto3Package "application-autoscaling" "1.28.36" "sha256-sxkmyfgk3FJPrS9SUJrHA4tNADM8g+wGaEEPnZjv2H4=";

  mypy-boto3-application-insights = buildMypyBoto3Package "application-insights" "1.28.36" "sha256-jNzhi3ashmQFH7QRi28UY5ZZ/su8RwzhU1XzmunOiro=";

  mypy-boto3-applicationcostprofiler = buildMypyBoto3Package "applicationcostprofiler" "1.28.36" "sha256-keA+JdfyJVGf388qcA0HTIq9bUiMeEbcg1/s/SI7mt4=";

  mypy-boto3-appmesh = buildMypyBoto3Package "appmesh" "1.28.36" "sha256-1Cf+Mzgg0KDqBRpCWeCR0lbR5q8KJM+p/p2we6925b0=";

  mypy-boto3-apprunner = buildMypyBoto3Package "apprunner" "1.28.55" "sha256-lBbqHhOqWoudqK4NDFNSpzR/UA/dLCHzFmZWQSNhJLY=";

  mypy-boto3-appstream = buildMypyBoto3Package "appstream" "1.28.49" "sha256-5TgCIA4bbUHgxMcLHrWPEyIIYhjlCXZlvW8mYubA0+I=";

  mypy-boto3-appsync = buildMypyBoto3Package "appsync" "1.28.36" "sha256-Qag3caLiBRlUWl+TbUQjGkoAbQk+CEbuzZAJgq21PdE=";

  mypy-boto3-arc-zonal-shift = buildMypyBoto3Package "arc-zonal-shift" "1.28.36" "sha256-hTGtmMTWhsMqo+Vq2Bxtfo1sGezi1vD05LsQyGOl9Ps=";

  mypy-boto3-athena = buildMypyBoto3Package "athena" "1.28.36" "sha256-p232qs49wdkbP3RkDWF80bSALl80iiLbLxbfzgsB7iY=";

  mypy-boto3-auditmanager = buildMypyBoto3Package "auditmanager" "1.28.38" "sha256-t32bXFUOsVNVs+1Sagx2PIO7/Re6gN2cOevLj+7gbqo=";

  mypy-boto3-autoscaling = buildMypyBoto3Package "autoscaling" "1.28.36" "sha256-3b2iUNeY/8ZcZZsyqHTNTsGMwWBxCeiOm+1Tpq+iYf8=";

  mypy-boto3-autoscaling-plans = buildMypyBoto3Package "autoscaling-plans" "1.28.36" "sha256-Hx/rpODs11SdfZTQTcOYAIsPbiLDpreqLdbBHGIEp5E=";

  mypy-boto3-backup = buildMypyBoto3Package "backup" "1.28.36" "sha256-LbGiDazOf32hEoxGTZlTtH9iTj+3ru+sCO0VAMCfN6E=";

  mypy-boto3-backup-gateway = buildMypyBoto3Package "backup-gateway" "1.28.36" "sha256-AGbffUSt3ndl5a0B5nl9CYgYExaM1JLT53T9jVJxeno=";

  mypy-boto3-backupstorage = buildMypyBoto3Package "backupstorage" "1.28.36" "sha256-Km6lRkCrsWep/kAlPXplbyfHyy5D5nnrd0j0v8FID00=";

  mypy-boto3-batch = buildMypyBoto3Package "batch" "1.28.36" "sha256-SEDD3Fjd4y337atj+RVUKIvpUd0oCvje8gOF1/Rg7Gs=";

  mypy-boto3-billingconductor = buildMypyBoto3Package "billingconductor" "1.28.41" "sha256-aUphZNHrTLUt4dOvg+GmZR7z3whq5jx2PVsjvcY0qS0=";

  mypy-boto3-braket = buildMypyBoto3Package "braket" "1.28.53" "sha256-fMNDKmjx/2hUJHWEWcveYbsbIkiWUXTQSv4itP8zOas=";

  mypy-boto3-budgets = buildMypyBoto3Package "budgets" "1.28.57" "sha256-Af6omXHyctUeXbEOQC/KoiE3ux88r/hyxlWQoMM1eF4=";

  mypy-boto3-ce = buildMypyBoto3Package "ce" "1.28.36" "sha256-lBrKm4s1QPGTuZHtHt+uNhX9zsMhNuV0l23822IYIDI=";

  mypy-boto3-chime = buildMypyBoto3Package "chime" "1.28.37" "sha256-fg8svfLvw+Rzhcr+HxrjHtXw9UE1vuccaOFvjfgxC58=";

  mypy-boto3-chime-sdk-identity = buildMypyBoto3Package "chime-sdk-identity" "1.28.37" "sha256-r+UvZ213ffIOdmZ1V8MNtZN/i3ozeKfwv7VIvJZ4CRg=";

  mypy-boto3-chime-sdk-media-pipelines = buildMypyBoto3Package "chime-sdk-media-pipelines" "1.28.54" "sha256-ewC4woDpDkGUBvPgjpcctkO860EJWHGvZrgCgXSsPbA=";

  mypy-boto3-chime-sdk-meetings = buildMypyBoto3Package "chime-sdk-meetings" "1.28.36" "sha256-OZijI8aLKnnZnXf3q8LmePd9ncIrDj2zRq19tNlNQTk=";

  mypy-boto3-chime-sdk-messaging = buildMypyBoto3Package "chime-sdk-messaging" "1.28.37" "sha256-qMLqjzniJfyVCfnMGiIPMRzQoIj309P5WDBjy1P7B8Y=";

  mypy-boto3-chime-sdk-voice = buildMypyBoto3Package "chime-sdk-voice" "1.28.36" "sha256-e627SiCiQV38AzvYusuNEsD9XoYkTYYbaTMJ2odKzAo=";

  mypy-boto3-cleanrooms = buildMypyBoto3Package "cleanrooms" "1.28.38" "sha256-fbuCwuzXiK9ekk30m90WZW7LcDFLeR/Ta9BvFnT/wnU=";

  mypy-boto3-cloud9 = buildMypyBoto3Package "cloud9" "1.28.47" "sha256-vV+cqYs7msRzBkIIz4uA123QM54gFpi1q9lXo997BOk=";

  mypy-boto3-cloudcontrol = buildMypyBoto3Package "cloudcontrol" "1.28.36" "sha256-DshOzjolyUCztdlOqxxvRlKIIJP6izeyhp2Wl6ObCrY=";

  mypy-boto3-clouddirectory = buildMypyBoto3Package "clouddirectory" "1.28.36" "sha256-ikyPoBWFRXl95QylMg3rstBymj3HKZqQs0orb14Uorg=";

  mypy-boto3-cloudformation = buildMypyBoto3Package "cloudformation" "1.28.48" "sha256-775Aczl4AIJCh8jVKmU4MRKGL5A7Fv1Ye1ETRJZSNxs=";

  mypy-boto3-cloudfront = buildMypyBoto3Package "cloudfront" "1.28.36" "sha256-lY3dwCA/xw6YIgmmJeglC3/mHubiKNqPqrrif6ZreDc=";

  mypy-boto3-cloudhsm = buildMypyBoto3Package "cloudhsm" "1.28.39" "sha256-1K3HPvtZSkQZD5/V9T0tXv6PC2NSoB5v5aR20OWV6kw=";

  mypy-boto3-cloudhsmv2 = buildMypyBoto3Package "cloudhsmv2" "1.28.36" "sha256-mxvW/ge2gEkGF0rz4LJZCkEIveNGkt9ud5bqs4WhlBs=";

  mypy-boto3-cloudsearch = buildMypyBoto3Package "cloudsearch" "1.28.36" "sha256-fEGcYuWWDHOalygjig2qdMn8A3T4vBYZIbZRHtRRQns=";

  mypy-boto3-cloudsearchdomain = buildMypyBoto3Package "cloudsearchdomain" "1.28.36" "sha256-yRUv7XlIpCqkyFw+whHh07LUw0aKbcRa0UkR6zpVtCA=";

  mypy-boto3-cloudtrail = buildMypyBoto3Package "cloudtrail" "1.28.36" "sha256-YUrRZ53Wdd4CCjq9VYRkAIGxu2wYTaqXF7Fp4DA7jM4=";

  mypy-boto3-cloudtrail-data = buildMypyBoto3Package "cloudtrail-data" "1.28.36" "sha256-aUZYh0fTrcv1d56HRdu7u4CzAMiCvVlN/tKY1e7piLM=";

  mypy-boto3-cloudwatch = buildMypyBoto3Package "cloudwatch" "1.28.36" "sha256-108mLOQPp+qUdIBWHlN2UO5pRrIIrAf2wM/a/BYAFEM=";

  mypy-boto3-codeartifact = buildMypyBoto3Package "codeartifact" "1.28.52" "sha256-kmPzmdQj79l+8KY7Q/E4qTxCxAEhEPivYiR1Hh04qm0=";

  mypy-boto3-codebuild = buildMypyBoto3Package "codebuild" "1.28.36" "sha256-po4qcd6jiYjqMQj7aP+eMzNJcmwjYP22Q92fHkx1q5U=";

  mypy-boto3-codecatalyst = buildMypyBoto3Package "codecatalyst" "1.28.36" "sha256-IuFxPWpE6zCGfbVfhTBtueUSspeVaq9TrESkfHdrxI8=";

  mypy-boto3-codecommit = buildMypyBoto3Package "codecommit" "1.28.36" "sha256-o/kVzldUZNfMmK3Ni5L0kOLjKLxsB93YwutqM5GvHqQ=";

  mypy-boto3-codedeploy = buildMypyBoto3Package "codedeploy" "1.28.55" "sha256-jkN9DCiS5fKhBq7752gRzHwmfdohQBZOSNGaA1OxVbc=";

  mypy-boto3-codeguru-reviewer = buildMypyBoto3Package "codeguru-reviewer" "1.28.36" "sha256-xUkKfYEBmqA0D8RKxbf8VF0XeYOgwNWh1y7ORnj1VpM=";

  mypy-boto3-codeguru-security = buildMypyBoto3Package "codeguru-security" "1.28.36" "sha256-EU6VTdhzWLofMEFF0vOXTDpJI/BkC3FpSAz1rbtbFWA=";

  mypy-boto3-codeguruprofiler = buildMypyBoto3Package "codeguruprofiler" "1.28.36" "sha256-DHUALwX0ec7rzaSsU0vASersuuHpJXY8cDI8cDhzgl0=";

  mypy-boto3-codepipeline = buildMypyBoto3Package "codepipeline" "1.28.36" "sha256-isqRkPLovlkHgmBuuYDPBTaBlOdu3LgwajD+z3luO8c=";

  mypy-boto3-codestar = buildMypyBoto3Package "codestar" "1.28.36" "sha256-+D1SBuI6JMA0ISBv5OiGkA43dOESGH4d4m8CUN4Uhxk=";

  mypy-boto3-codestar-connections = buildMypyBoto3Package "codestar-connections" "1.28.36" "sha256-1K0mrUUO0ycP7uBCqnESd/iGiElL0eqJfwLTpgPH5a0=";

  mypy-boto3-codestar-notifications = buildMypyBoto3Package "codestar-notifications" "1.28.36" "sha256-BYTeNmL6fKXD6Ym0Z3DOZvLaTqRwANDWfCcWs9TUZ+Y=";

  mypy-boto3-cognito-identity = buildMypyBoto3Package "cognito-identity" "1.28.36" "sha256-fJIKiNsKDcoDtTIRMxbxpcO6QZOl8KnCn2qTkb4owLI=";

  mypy-boto3-cognito-idp = buildMypyBoto3Package "cognito-idp" "1.28.36" "sha256-pnLO62LZvr4sJsye3gWJROY+xHikSe7dX8erBTRXrPc=";

  mypy-boto3-cognito-sync = buildMypyBoto3Package "cognito-sync" "1.28.36" "sha256-Hx+/3Q+FLMeDRu+ijTl80WbmqjW/jzpW8eDar8hu/ro=";

  mypy-boto3-comprehend = buildMypyBoto3Package "comprehend" "1.28.37" "sha256-OK8LtQoV2Ccqc4qjRBNJirRDM8wHR7VDzcgbaJNrGok=";

  mypy-boto3-comprehendmedical = buildMypyBoto3Package "comprehendmedical" "1.28.36" "sha256-6uyeuxkhRD5Xpfh5u09U28Zg1OzLyzwhgQZ/LRGI9lc=";

  mypy-boto3-compute-optimizer = buildMypyBoto3Package "compute-optimizer" "1.28.41" "sha256-TYY9yrw8Az+x01fp3mXc2zzX7YBdnAQQr1uy+E8FkdQ=";

  mypy-boto3-config = buildMypyBoto3Package "config" "1.28.36" "sha256-3NUJLfbriTXMsGyj+8XNbhI37BLVSm+sShaJJIz6I7s=";

  mypy-boto3-connect = buildMypyBoto3Package "connect" "1.28.55" "sha256-sA6ef9iOyRrCKwxsSHU19IaBwYiVKeTR0+k94wUX4gw=";

  mypy-boto3-connect-contact-lens = buildMypyBoto3Package "connect-contact-lens" "1.28.36" "sha256-7+DHcEkDov1/0mNu/mbKaCwwPfvGRYSEfp3+4tnOnuY=";

  mypy-boto3-connectcampaigns = buildMypyBoto3Package "connectcampaigns" "1.28.39" "sha256-4c074TlgMh8YxdOl9vb+Xs0JEs5k0mA5rYaF+BIH3Ps=";

  mypy-boto3-connectcases = buildMypyBoto3Package "connectcases" "1.28.36" "sha256-oYU/yw9CUltwPfvONhCvH6gCXirzKF26RZj9hdKTtPQ=";

  mypy-boto3-connectparticipant = buildMypyBoto3Package "connectparticipant" "1.28.39" "sha256-iOv8UX4eh07Dwk7zvtv1YXeDiX/RHhuEMGzLafBk+kI=";

  mypy-boto3-controltower = buildMypyBoto3Package "controltower" "1.28.36" "sha256-0j6Fa0hobGlNfvMDmlNrqp4EqIhnYTo9XJ41VpEY+Cs=";

  mypy-boto3-cur = buildMypyBoto3Package "cur" "1.28.36" "sha256-pWKHl8zKmx3ypQOiWtFzRb92630sLJVO0qmn5KEZJ14=";

  mypy-boto3-customer-profiles = buildMypyBoto3Package "customer-profiles" "1.28.39" "sha256-wAghxGUIThqLBfThNliSu39Dl8vmO8QCrfbxvQOuHxc=";

  mypy-boto3-databrew = buildMypyBoto3Package "databrew" "1.28.36" "sha256-LhvgmeMOlP4EAmx3Xd97ZiHi/FeChpGtZ1LIuGkTnMU=";

  mypy-boto3-dataexchange = buildMypyBoto3Package "dataexchange" "1.28.36" "sha256-cNgpRQTJ2JhPw+UZo+HiulWg1998kfgnAB/E6gyvetI=";

  mypy-boto3-datapipeline = buildMypyBoto3Package "datapipeline" "1.28.36" "sha256-IkO7QXwdEWmkzaCOrCWTzNv1xpvwOHGp9wlris/KEws=";

  mypy-boto3-datasync = buildMypyBoto3Package "datasync" "1.28.49" "sha256-BcW47DW0aHb+Gabj6fybaiZgtKotWNvNChyKyaagIw4=";

  mypy-boto3-dax = buildMypyBoto3Package "dax" "1.28.36" "sha256-t5DMgU3iSxWLSXpC9QaNonKKQpl0tr/gQPnPxO+dTbY=";

  mypy-boto3-detective = buildMypyBoto3Package "detective" "1.28.36" "sha256-RGSt2jtwDqC3qWh+Z6IfWoiVpoLDjSqLTSjo7+SUL3Q=";

  mypy-boto3-devicefarm = buildMypyBoto3Package "devicefarm" "1.28.36" "sha256-TSxUsHAhGY4rgscwesf6mnlya8kHb6MZGKPzhud/OC0=";

  mypy-boto3-devops-guru = buildMypyBoto3Package "devops-guru" "1.28.36" "sha256-Whn1VVBzBdav0D31XCH5izyVmZGg/ndPlOamIoY5U94=";

  mypy-boto3-directconnect = buildMypyBoto3Package "directconnect" "1.28.36" "sha256-YUZ2XsKaPLi4qDF1Cuf5/6BZ1Pi+xf65hTBc0NHfQTc=";

  mypy-boto3-discovery = buildMypyBoto3Package "discovery" "1.28.50" "sha256-bUFzZ+Ipw3hmaTvBBPlLRz48U+alvfLBiOKNljEap38=";

  mypy-boto3-dlm = buildMypyBoto3Package "dlm" "1.28.36" "sha256-i+OVrnJ+irxgIWi0ZEad6lPLNwT1cvfQ+0xKKXWe8z0=";

  mypy-boto3-dms = buildMypyBoto3Package "dms" "1.28.53" "sha256-CY3bGLiiciRnscCsqOSdFv04YKDG4gN7f/q3um7QwZ8=";

  mypy-boto3-docdb = buildMypyBoto3Package "docdb" "1.28.36" "sha256-Dbg80rvJBHkXEzLLWeEi7jN6OrVZiJ6+C6wYkhM72J0=";

  mypy-boto3-docdb-elastic = buildMypyBoto3Package "docdb-elastic" "1.28.36" "sha256-XvcexadEtui/Wh2sZnketqygNgpGfaSAGciM64Yc+Sk=";

  mypy-boto3-drs = buildMypyBoto3Package "drs" "1.28.47" "sha256-4JBlsWQLu1KsPSTxwy/ySNQM1ZlIaX1sORvES8Lut00=";

  mypy-boto3-ds = buildMypyBoto3Package "ds" "1.28.36" "sha256-l/k+1VhA6mi6mVRKCUis0gAv/dizqZB5JIqLmj9+IDI=";

  mypy-boto3-dynamodb = buildMypyBoto3Package "dynamodb" "1.28.55" "sha256-owOfitoHohj5fwxwqC7Zz0YaDLUTMZT88eDoexXImaU=";

  mypy-boto3-dynamodbstreams = buildMypyBoto3Package "dynamodbstreams" "1.28.36" "sha256-mqz+YRVZlSbwEKYbaC4ZbWw0qJTXpRObAphfI4sfRV4=";

  mypy-boto3-ebs = buildMypyBoto3Package "ebs" "1.28.36" "sha256-w9OLKJAn9UBnA7x+uedhplSV8plZRYlBpviU9Gv1Ny8=";

  mypy-boto3-ec2 = buildMypyBoto3Package "ec2" "1.28.58" "sha256-p4BGJSydAqtSMH8PFFc/IAwBquLHCq1I6vW50UNySRo=";

  mypy-boto3-ec2-instance-connect = buildMypyBoto3Package "ec2-instance-connect" "1.28.36" "sha256-oVcd5yqbg8Drozgmog4nonRSe4nOM7rwpqZi9HVYTL0=";

  mypy-boto3-ecr = buildMypyBoto3Package "ecr" "1.28.45" "sha256-NYShmgGLrNe26BR7ye9pMpZ4FcCRjGzzkp/1Xxyb5gE=";

  mypy-boto3-ecr-public = buildMypyBoto3Package "ecr-public" "1.28.36" "sha256-LiFZtqdGf9tC6Tj4ukclFyaq/bLos5jZCgPL1y/0VMU=";

  mypy-boto3-ecs = buildMypyBoto3Package "ecs" "1.28.41" "sha256-/aXw4fpS4o3/Jt+jfzm0p4zqZVcoSJLlk9EUMd3+SVo=";

  mypy-boto3-efs = buildMypyBoto3Package "efs" "1.28.53" "sha256-QhSddCRqWUly2w+GLZJHJn/TKpQHbQO88yKny6nj/ZI=";

  mypy-boto3-eks = buildMypyBoto3Package "eks" "1.28.36" "sha256-etvfyKLFr4lKE9DLvKQuHw2YHshhOBTXXTCvDv2hFxE=";

  mypy-boto3-elastic-inference = buildMypyBoto3Package "elastic-inference" "1.28.36" "sha256-BwI32rA8Y1lhc+k/XQh+LHPlFHmaCTr37OYvLFJMX1o=";

  mypy-boto3-elasticache = buildMypyBoto3Package "elasticache" "1.28.36" "sha256-6Ymobcuhh1dOqA9IoN9lWrj639ZKu/NQEP6ImlhapFA=";

  mypy-boto3-elasticbeanstalk = buildMypyBoto3Package "elasticbeanstalk" "1.28.36" "sha256-V2vSEaN7Kf2TPateMNtJ95a+Ad/CRcZOV2JsJlTOPIo=";

  mypy-boto3-elastictranscoder = buildMypyBoto3Package "elastictranscoder" "1.28.36" "sha256-lkz4up43fVyWCOO9dM4xI285wsAu1lnV4mICuJV8D4k=";

  mypy-boto3-elb = buildMypyBoto3Package "elb" "1.28.36" "sha256-c9Re0WZOn+LaK58VJk+YlI3YWn/wrgT+/TdqrOisBnM=";

  mypy-boto3-elbv2 = buildMypyBoto3Package "elbv2" "1.28.42" "sha256-NXyhMxuIbuyyDifzBicvDNQB3ysbVx+azsqpTBhfnZ8=";

  mypy-boto3-emr = buildMypyBoto3Package "emr" "1.28.36" "sha256-DrhDkqcxAAUTfheZRpPJQkFFzeDynByF2wn9jyZr0F4=";

  mypy-boto3-emr-containers = buildMypyBoto3Package "emr-containers" "1.28.36" "sha256-ZG7mf4C31COK7hobIbTLmd64Ydu2Al+NhSMrS8069jQ=";

  mypy-boto3-emr-serverless = buildMypyBoto3Package "emr-serverless" "1.28.54" "sha256-cDbUY1Ftlhyid7CiMEhY7ZepqH2bANrwlU8wdrdDqc4=";

  mypy-boto3-entityresolution = buildMypyBoto3Package "entityresolution" "1.28.48" "sha256-xCYg+Ik/VQpDjRR7QKlYyBffsGWZ7PSl531sTSvMv48=";

  mypy-boto3-es = buildMypyBoto3Package "es" "1.28.36" "sha256-NfMTzKYwYgZ+dbyIzxn+3poLWo8zjF8ANGWQFtMRTbk=";

  mypy-boto3-events = buildMypyBoto3Package "events" "1.28.46" "sha256-/a4rUcfBPQBFxqCnwt23NeZ655B3CEoo+SKHBZMJGtE=";

  mypy-boto3-evidently = buildMypyBoto3Package "evidently" "1.28.36" "sha256-U3igtB9eGBYv8VW+PQXD2fc16FKiYl8musH/ccrrMKA=";

  mypy-boto3-finspace = buildMypyBoto3Package "finspace" "1.28.36" "sha256-3l1/ACy5Z09z/ngQKdq3dgBTp05x+NUCRjj1z8I99/4=";

  mypy-boto3-finspace-data = buildMypyBoto3Package "finspace-data" "1.28.54" "sha256-V5Rxrp94hrUWZgpc+LDn1PwyzZREHDXq3NaZdZQaYoE=";

  mypy-boto3-firehose = buildMypyBoto3Package "firehose" "1.28.56" "sha256-IPwUkzEymLJ4NgB2OrD4mr5hZsmTaGjbbxCiHyFaaDw=";

  mypy-boto3-fis = buildMypyBoto3Package "fis" "1.28.36" "sha256-km9Ia9Hs/rZv3ljv+BVnR9pOxNK3u5luJOMaW670km0=";

  mypy-boto3-fms = buildMypyBoto3Package "fms" "1.28.36" "sha256-mzumkMcF2TMrcnHoPPA0SlrmwFAw0TR1cMvSXF28gvM=";

  mypy-boto3-forecast = buildMypyBoto3Package "forecast" "1.28.36" "sha256-DCa0GNn7XL3iVgGl5M6E7uyPFdyYjrHfqHakCS7clcc=";

  mypy-boto3-forecastquery = buildMypyBoto3Package "forecastquery" "1.28.36" "sha256-s2z8QZR9PP8Kj6yImCwUfh/gtbj4SKLn8wDTOYUVaEE=";

  mypy-boto3-frauddetector = buildMypyBoto3Package "frauddetector" "1.28.36" "sha256-Zn3rGHErin7nPYnyC0Ojr0Kkc5T+YDD2KmZinYNV9Jg=";

  mypy-boto3-fsx = buildMypyBoto3Package "fsx" "1.28.44" "sha256-t90+ngxgivF/KThwaB6/LNPZAHL2oLenhl6KUzSZSzU=";

  mypy-boto3-gamelift = buildMypyBoto3Package "gamelift" "1.28.36" "sha256-ADxlyEX5KgAewNFq7JhYECNIhaoKiPkdqWK2pnS+65A=";

  mypy-boto3-gamesparks = buildMypyBoto3Package "gamesparks" "1.28.36" "sha256-6lQXNJ55FYvkFA14rgJGhRMjBHA3YrOybnsKNecX7So=";

  mypy-boto3-glacier = buildMypyBoto3Package "glacier" "1.28.36" "sha256-L0a7CoD9I0wM8JvzaAxL8bm1SV1XmFi5lvs2SuGPtl4=";

  mypy-boto3-globalaccelerator = buildMypyBoto3Package "globalaccelerator" "1.28.36" "sha256-+nnFS/7kJHvqqiwqkWnYlgeIuSecicI1P+UtWyGUoGQ=";

  mypy-boto3-glue = buildMypyBoto3Package "glue" "1.28.36" "sha256-FhdxJSu2oiCgv9jmrXHahUhZnGEflf6KlIRvSjOG0q4=";

  mypy-boto3-grafana = buildMypyBoto3Package "grafana" "1.28.39" "sha256-OsEvT2f3LEvjz6aojIpG2scoZ80hETvk8t/BTumn+9M=";

  mypy-boto3-greengrass = buildMypyBoto3Package "greengrass" "1.28.36" "sha256-vH/viSZe2UcjtbwGN2Zcf9IB1boBHhL3zmy3IHN1rpg=";

  mypy-boto3-greengrassv2 = buildMypyBoto3Package "greengrassv2" "1.28.36" "sha256-VdsQUNg3a2PUaP8rgx3I1ZxUW4hqJsBCS0B8+7CfP1w=";

  mypy-boto3-groundstation = buildMypyBoto3Package "groundstation" "1.28.36" "sha256-M0HaOpC6zbIaN3VVcM9oE/QzL+me4d5Co5miJGMU3n8=";

  mypy-boto3-guardduty = buildMypyBoto3Package "guardduty" "1.28.53" "sha256-ctMp5+GrKYICPioPi5kB7cnxoP9QFIfbYiDxqf/pPCw=";

  mypy-boto3-health = buildMypyBoto3Package "health" "1.28.39" "sha256-yp8r38QxJVKxiZtrCgvUcuqz2HnTM2IvYjyYGTgAqYc=";

  mypy-boto3-healthlake = buildMypyBoto3Package "healthlake" "1.28.36" "sha256-RYbiExGphCkf8v+oC3ixOOFOnUrXE2bGnOvjRUGdQRQ=";

  mypy-boto3-honeycode = buildMypyBoto3Package "honeycode" "1.28.36" "sha256-pOWZ+WNmgWwGz1sPq/feZiQ2TlXDcpoWMXcDPSESJOY=";

  mypy-boto3-iam = buildMypyBoto3Package "iam" "1.28.37" "sha256-Ob1bi5pIy0fZCdRcE8cTwJnC+EcZYSoKhI16BJfG/PQ=";

  mypy-boto3-identitystore = buildMypyBoto3Package "identitystore" "1.28.40" "sha256-KPPWrEMuciHf3ms3SkUgAaEFNPa5WyFKm5fFfG4o9G8=";

  mypy-boto3-imagebuilder = buildMypyBoto3Package "imagebuilder" "1.28.36" "sha256-2fJtgGfwkY3V07kXAiyi61TUmvq3BVqiN+EFzxTQkvI=";

  mypy-boto3-importexport = buildMypyBoto3Package "importexport" "1.28.36" "sha256-806+dIMqKZ14MifNoDqKgj8MGPYBQVd8KnT+V+eOr/E=";

  mypy-boto3-inspector = buildMypyBoto3Package "inspector" "1.28.36" "sha256-plSUqqsTvOMxMeAYueWNpK8JFHdeOOr8DfgSZov9Gbw=";

  mypy-boto3-inspector2 = buildMypyBoto3Package "inspector2" "1.28.36" "sha256-O20aGL3EhyS5HNYlY6Jv1n0OIUWPr3L2VVjReHwpAGM=";

  mypy-boto3-internetmonitor = buildMypyBoto3Package "internetmonitor" "1.28.47" "sha256-qNv+Qi/5eZ5oUsysYokQufE3BgL32BzA9gdxWsJ6ocU=";

  mypy-boto3-iot = buildMypyBoto3Package "iot" "1.28.56" "sha256-dLDUJEflskkXKb6soxoKRoPxko/Qb9lWkKjPnVklUWc=";

  mypy-boto3-iot-data = buildMypyBoto3Package "iot-data" "1.28.36" "sha256-DDUn2TFgXeeltWJqH7g7D+gKLSQv832/J4lWBVyWmlQ=";

  mypy-boto3-iot-jobs-data = buildMypyBoto3Package "iot-jobs-data" "1.28.36" "sha256-bpKEm6reRSLi74HT9wMGN+xkJPTYSLxOGf8Z7QN1qMY=";

  mypy-boto3-iot-roborunner = buildMypyBoto3Package "iot-roborunner" "1.28.36" "sha256-DFaWmHPzlgZztGfbbxeyDWu2rGLm69r8Ejww5cvzkRQ=";

  mypy-boto3-iot1click-devices = buildMypyBoto3Package "iot1click-devices" "1.28.36" "sha256-GROHe78qVJLlPtw+wH73fzyBjTsrKkUbpVN0U26HsJs=";

  mypy-boto3-iot1click-projects = buildMypyBoto3Package "iot1click-projects" "1.28.36" "sha256-XAtVZ+j5k8eb1G79B+sin/W3bVfq+Vtr/P80BU2XnVQ=";

  mypy-boto3-iotanalytics = buildMypyBoto3Package "iotanalytics" "1.28.36" "sha256-jO+/523WSPqhQCAOr6nFiag/tCHL1Up1A0q76jZ7/qE=";

  mypy-boto3-iotdeviceadvisor = buildMypyBoto3Package "iotdeviceadvisor" "1.28.36" "sha256-0v8vHIOzHO7ZEZEA08hzukJV9EFSnTFh/1K1h3RhCyY=";

  mypy-boto3-iotevents = buildMypyBoto3Package "iotevents" "1.28.36" "sha256-27oaZTqmrBRJ3xlE9QKqLkau+dR30aYdeczVaWwK1Xs=";

  mypy-boto3-iotevents-data = buildMypyBoto3Package "iotevents-data" "1.28.36" "sha256-De7a/DdIEmK9jkd6CekBQ+ZNlp+5hyavdY5ISYNLM20=";

  mypy-boto3-iotfleethub = buildMypyBoto3Package "iotfleethub" "1.28.36" "sha256-AH9zk6pQ5OhupzG9lkZGSAX/ngrFovlldGkfn40TZh4=";

  mypy-boto3-iotfleetwise = buildMypyBoto3Package "iotfleetwise" "1.28.57" "sha256-KE8Q0jmXGhRAD3SmioxKVabyM0zLQEvhzogGEAMGvtU=";

  mypy-boto3-iotsecuretunneling = buildMypyBoto3Package "iotsecuretunneling" "1.28.36" "sha256-ANWiAgtmQCchCYvPPXUGdUHYLJOCoQAsFz8ybpZSceg=";

  mypy-boto3-iotsitewise = buildMypyBoto3Package "iotsitewise" "1.28.36" "sha256-Sr5hmTMLMDxxXwG6s+wv5kkq4NnFCTFjMisOwdniBN4=";

  mypy-boto3-iotthingsgraph = buildMypyBoto3Package "iotthingsgraph" "1.28.36" "sha256-msc7aVFDSQRUNeqHWFqJ+4haUvCq+VYCpmZONl7+ySA=";

  mypy-boto3-iottwinmaker = buildMypyBoto3Package "iottwinmaker" "1.28.36" "sha256-laSFI1ugTL+9bVVQLuMKvQ9WGgXGikvV3k1DsyTIJ00=";

  mypy-boto3-iotwireless = buildMypyBoto3Package "iotwireless" "1.28.36" "sha256-CAAkka/CEZ1D+MgK1cbWDm6mArcRPxAo98Rz3ti6oHk=";

  mypy-boto3-ivs = buildMypyBoto3Package "ivs" "1.28.39" "sha256-bsUwfBojGMRujL9yLhIqBLAxEpgz1H3KCSmhoQ/UrfM=";

  mypy-boto3-ivs-realtime = buildMypyBoto3Package "ivs-realtime" "1.28.47" "sha256-f5aHtTu7H0TY3XYW1OJIkwKlKe6iZj0nxEjwlbEmc/4=";

  mypy-boto3-ivschat = buildMypyBoto3Package "ivschat" "1.28.36" "sha256-WMq8phYMtEl8Ey7tDxBzVexuR4gmZQlO6qpDwYu8xwY=";

  mypy-boto3-kafka = buildMypyBoto3Package "kafka" "1.28.36" "sha256-93kbJxpiLQsnhudgnGoGUimUPfhGMN0cc1x8qqsA/Jc=";

  mypy-boto3-kafkaconnect = buildMypyBoto3Package "kafkaconnect" "1.28.39" "sha256-p2vmaWN7oBdsud3bCB2/rCme7IXKJ4xI/XSFj4AqmGo=";

  mypy-boto3-kendra = buildMypyBoto3Package "kendra" "1.28.46" "sha256-zeKYrDZdcdNISV2eukD7GN/sdve8R5PNbvOhZN5FyRI=";

  mypy-boto3-kendra-ranking = buildMypyBoto3Package "kendra-ranking" "1.28.36" "sha256-C1wYGskKNR6E4bL6OR8ERRwHZ8HpTbhCAoiBKIAsgME=";

  mypy-boto3-keyspaces = buildMypyBoto3Package "keyspaces" "1.28.36" "sha256-p5Tj7bqC/E552Mmr/G+QxOA4LyW4YK9VlztEhKNw/Fc=";

  mypy-boto3-kinesis = buildMypyBoto3Package "kinesis" "1.28.36" "sha256-Q3E8DOj2Oyy9GBEy5xNxAxvZDqwlCu9zV7I51NprhQQ=";

  mypy-boto3-kinesis-video-archived-media = buildMypyBoto3Package "kinesis-video-archived-media" "1.28.36" "sha256-v3hjhhFbCTKsfYTUvI57lEvnRSIX5POdjH/4hC+GthA=";

  mypy-boto3-kinesis-video-media = buildMypyBoto3Package "kinesis-video-media" "1.28.36" "sha256-Si9Dz0blHg5oq8Nnq/6V5NMmt3Zbl9rVt8/UcfwSgnU=";

  mypy-boto3-kinesis-video-signaling = buildMypyBoto3Package "kinesis-video-signaling" "1.28.36" "sha256-sOiEpuZ3AMYRK6daSsoK3ti9LN4v7GgBPSThWTh25Og=";

  mypy-boto3-kinesis-video-webrtc-storage = buildMypyBoto3Package "kinesis-video-webrtc-storage" "1.28.36" "sha256-AJPSjIIX+AQKXPPoNxTESszrC5ZzQhwHeb/eTF/LJkE=";

  mypy-boto3-kinesisanalytics = buildMypyBoto3Package "kinesisanalytics" "1.28.36" "sha256-K/NUI/VQjoxmiL3s7ASUBCBv9GWqKQYpz4o0+oohDFU=";

  mypy-boto3-kinesisanalyticsv2 = buildMypyBoto3Package "kinesisanalyticsv2" "1.28.36" "sha256-k+ftbXSH2gm76lsJvMdvAuAnWBVsLEh829o4x5rUQUQ=";

  mypy-boto3-kinesisvideo = buildMypyBoto3Package "kinesisvideo" "1.28.52" "sha256-X05ZXElPveZ44sea7a0F5oO+wIIpYgTISpUwvACPiEY=";

  mypy-boto3-kms = buildMypyBoto3Package "kms" "1.28.37" "sha256-l4RcfT1vhG8hlaWdapdDB6FqCFseZP56/kDppcBra48=";

  mypy-boto3-lakeformation = buildMypyBoto3Package "lakeformation" "1.28.55" "sha256-RgYc0eRv7agKmJVwqTqsx2ua0Y1B8UHbwQ1eCh5kumU=";

  mypy-boto3-lambda = buildMypyBoto3Package "lambda" "1.28.36" "sha256-cEmOb/a/1gt1hVPSf632kboWlXL6ygHCvUV9oLSLnP8=";

  mypy-boto3-lex-models = buildMypyBoto3Package "lex-models" "1.28.36" "sha256-pe4WZgqSF3iodWqXn94fzNChq946ZydQlwJF7CB0HMc=";

  mypy-boto3-lex-runtime = buildMypyBoto3Package "lex-runtime" "1.28.36" "sha256-pE1gAxoS2hb4N4H7irZNgXERAXBt/eWqF0CZZjszTyI=";

  mypy-boto3-lexv2-models = buildMypyBoto3Package "lexv2-models" "1.28.36" "sha256-6DXon6AyJugNzp9bKXfvspvWGdD11dV5qxBZa7AikbE=";

  mypy-boto3-lexv2-runtime = buildMypyBoto3Package "lexv2-runtime" "1.28.36" "sha256-6wP6YHyctJWXdPO8bmylwhxtJ3jltbWYyAxdu+5+X5w=";

  mypy-boto3-license-manager = buildMypyBoto3Package "license-manager" "1.28.36" "sha256-/XOD5I4y2PHzW9Y+akeF1Oovf04jeh4r4ZcxjUP4ZOU=";

  mypy-boto3-license-manager-linux-subscriptions = buildMypyBoto3Package "license-manager-linux-subscriptions" "1.28.36" "sha256-LuwZUXbQlSC1YSyfNuensyYVoKwy6cZzMbC2/bGJ5Pw=";

  mypy-boto3-license-manager-user-subscriptions = buildMypyBoto3Package "license-manager-user-subscriptions" "1.28.36" "sha256-KcTO20KTKnvcCykL5C4BqDFyj/Xrp0l6gH7JslRIzcQ=";

  mypy-boto3-lightsail = buildMypyBoto3Package "lightsail" "1.28.36" "sha256-3euT5o4jOo39mco4y7geAA7PBF6z7A3lj451xXnB98o=";

  mypy-boto3-location = buildMypyBoto3Package "location" "1.28.36" "sha256-Gl0Q4693qhG9Wii6KlQXw9B5hZcoYoNcsO6rptLGPHQ=";

  mypy-boto3-logs = buildMypyBoto3Package "logs" "1.28.52" "sha256-tR6bl5YSI7/iMUzhaIe70imFezlgph03JIDW1ogWi34=";

  mypy-boto3-lookoutequipment = buildMypyBoto3Package "lookoutequipment" "1.28.48" "sha256-RXWRC9LegKQlODn8zgQJEADZGSuCYMp4/HdFGUge3rU=";

  mypy-boto3-lookoutmetrics = buildMypyBoto3Package "lookoutmetrics" "1.28.36" "sha256-GDkmENl2VbNDdXS26ORGeEoK8YAURJJRVzoxAiFt9L8=";

  mypy-boto3-s3 = buildMypyBoto3Package "s3" "1.28.55" "sha256-sAiAn0SOdAdQEtT8VLAXbeC09JvDjjneMMoOdk63UFY=";

  mypy-boto3-xray = buildMypyBoto3Package "xray" "1.28.47" "sha256-1OiTpbaBm2aAls4A7ZaZBNAM8DTRuQcwNKJDq3lOKMY=";

}
