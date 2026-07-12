{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.services.seaweedfs;
in
  with lib; {
    options.services.seaweedfs = {
      package = mkPackageOption pkgs "seaweedfs" {};
      config = mkOption {
        type = types.nullOr types.attrs;
        description = ''
          Free-form attribute set with strings as keys and values.
          The keys are file names and the associated value is the file's text.
          All files defined here will be put into a folder and its path will be set as seaweedfs's config directory.
        '';
        default = null;
      };
      master = mkOption {
        description = "Options related to the seaweedfs master";
        default = {};
        type = with types;
          submodule {
            options = {
              enable = mkEnableOption "The seaweedfs master service";
              cpuProfile = mkOption {
                type = types.nullOr types.str;
                description = "Cpu profile output file";
                default = null;
              };
              defaultReplication = mkOption {
                type = types.nullOr types.str;
                description = "Default replication type if not specified";
                default = null;
              };
              disableHttp = mkOption {
                type = types.nullOr types.bool;
                description = "Disable http requests, only gRPC operations are allowed";
                default = null;
              };
              electionTimeout = mkOption {
                type = types.nullOr types.ints.positive;
                description = "Election timeout of master servers";
                default = null;
              };
              garbageThreshold = mkOption {
                type = types.nullOr types.float;
                description = "Threshold to vacuum and reclaim spaces";
                default = null;
              };
              heartbeatInterval = mkOption {
                type = types.nullOr types.ints.positive;
                description = "Heartbeat interval of master servers, and will be randomly multiplied by [1, 1.25)";
                default = null;
              };
              ip = mkOption {
                type = types.nullOr types.str;
                description = "Master <ip>|<server> address, also used as identifier";
                default = null;
              };
              ipBind = mkOption {
                type = types.nullOr types.str;
                description = "Ip address to bind to";
                default = null;
              };
              maxParallelVacuumPerServer = mkOption {
                type = types.nullOr types.ints.positive;
                description = "Maximum number of volumes to vacuum in parallel per volume server";
                default = null;
              };
              mdir = mkOption {
                type = types.nullOr types.str;
                description = "Data directory to store meta data";
                default = null;
              };
              memProfile = mkOption {
                type = types.nullOr types.str;
                description = "Memory profile output file";
                default = null;
              };
              metricsAddress = mkOption {
                type = types.nullOr types.str;
                description = "Prometheus gateway address";
                default = null;
              };
              metricsIntervalSeconds = mkOption {
                type = types.nullOr types.str;
                description = "Prometheus push interval in seconds";
                default = null;
              };
              metricsIp = mkOption {
                type = types.nullOr types.str;
                description = "Metrics listen ip. If empty, default to same as -ip.bind option";
                default = null;
              };
              metricsPort = mkOption {
                type = types.nullOr types.port;
                description = "Prometheus metrics listen port";
                default = null;
              };
              options = mkOption {
                type = types.nullOr types.port;
                description = "Path to a file of command line options, each line in optionName=optionValue format";
                default = null;
              };
              peers = mkOption {
                type = types.nullOr (types.listOf str);
                description = "All master nodes ip:port list";
                default = null;
              };
              port = mkOption {
                type = types.nullOr types.port;
                description = "HTTP listen port";
                default = null;
              };
              portGrpc = mkOption {
                type = types.nullOr types.port;
                description = "gRPC listen port";
                default = null;
              };
              raftBootstrap = mkOption {
                type = types.nullOr types.bool;
                description = "Whether to bootstrap the Raft cluster";
                default = null;
              };
              raftHashicorp = mkOption {
                type = types.nullOr types.bool;
                description = "Use hashicorp raft";
                default = null;
              };
              resumeState = mkOption {
                type = types.nullOr types.bool;
                description = "Resume previous state on start master server";
                default = null;
              };
              telemetry = mkOption {
                type = types.nullOr types.bool;
                description = "Enable telemetry reporting";
                default = null;
              };
              telemetryUrl = mkOption {
                type = types.nullOr types.str;
                description = "Telemetry server URL to send usage statistics";
                default = null;
              };
              volumePreallocate = mkOption {
                type = types.nullOr types.bool;
                description = "Preallocate disk space for volumes";
                default = null;
              };
              volumeSizeLimitMB = mkOption {
                type = types.nullOr types.ints.positive;
                description = "Master stops directing writes to oversized volumes";
                default = null;
              };
              whiteList = mkOption {
                type = types.nullOr types.str;
                description = "Comma separated Ip addresses having write permission";
                default = null;
              };
            };
          };
      };
      filer = mkOption {
        description = "Options related to the seaweedfs filer";
        default = {};
        type = with types;
          submodule {
            options = {
              enable = mkEnableOption "The seaweedfs filer service";
              allowedOrigins = mkOption {
                type = types.nullOr (types.listOf types.str);
                description = "Comma separated list of allowed origins";
                default = null;
              };
              collection = mkOption {
                type = types.nullOr types.str;
                description = "all data will be stored in this default collection";
                default = null;
              };
              concurrentUploadLimitMB = mkOption {
                type = types.nullOr types.ints.unsigned;
                description = "Limit total concurrent upload size";
                default = null;
              };
              concurrentDownloadLimitMB = mkOption {
                type = types.nullOr types.ints.unsigned;
                description = "Limit total concurrent download size";
                default = null;
              };
              dataCenter = mkOption {
                type = types.nullOr types.str;
                description = "Prefer to read and write to volumes in this data center";
                default = null;
              };
              debug = mkOption {
                type = types.nullOr types.bool;
                description = "Serves runtime profiling data, e.g., http://localhost:<debug.port>/debug/pprof/goroutine?debug=2";
                default = null;
              };
              debugPort = mkOption {
                type = types.nullOr types.port;
                description = "HTTP port for debugging";
                default = null;
              };
              defaultReplicaPlacement = mkOption {
                type = types.nullOr types.str;
                description = "Default replication type";
                default = null;
              };
              defaultStoreDir = mkOption {
                type = types.nullOr types.str;
                description = "If filer.toml is empty, use an embedded filer store in the directory";
                default = null;
              };
              dirListLimit = mkOption {
                type = types.nullOr types.ints.positive;
                description = "Limit sub dir listing size";
                default = null;
              };
              disableDirListing = mkOption {
                type = types.nullOr types.bool;
                description = "Turn off directory listing";
                default = null;
              };
              disableHttp = mkOption {
                type = types.nullOr types.bool;
                description = "Disable HTTP request, only gRPC operations are allowed";
                default = null;
              };
              disk = mkOption {
                type = types.nullOr types.str;
                description = "[hdd|ssd|<tag>] hard drive or solid state drive or any tag";
                default = null;
              };
              downloadMaxMBps = mkOption {
                type = types.nullOr types.ints.positive;
                description = "Download max speed for each download request, in MB per second";
                default = null;
              };
              encryptVolumeData = mkOption {
                type = types.nullOr types.bool;
                description = "Encrypt data on volume servers";
                default = null;
              };
              exposeDirectoryData = mkOption {
                type = types.nullOr types.bool;
                description = "Whether to return directory metadata and content in Filer UI";
                default = null;
              };
              filerGroup = mkOption {
                type = types.nullOr types.str;
                description = "Share metadata with other filers in the same filerGroup";
                default = null;
              };
              iam = mkOption {
                description = "Options related to IAM";
                default = {};
                type = with types;
                  submodule {
                    options = {
                      enable = mkOption {
                        type = types.nullOr types.bool;
                        description = "Whether to enable the IAM service";
                        default = null;
                      };
                      ip = mkOption {
                        type = types.nullOr types.str;
                        description = "IAM server http listen ip address";
                        default = null;
                      };
                      port = mkOption {
                        type = types.nullOr types.port;
                        description = "IAM server http listen port";
                        default = null;
                      };
                    };
                  };
              };
              ip = mkOption {
                type = types.nullOr types.str;
                description = "Filer server http listen ip address";
                default = null;
              };
              ipBind = mkOption {
                type = types.nullOr types.str;
                description = "IP address to bind to";
                default = null;
              };
              localSocket = mkOption {
                type = types.nullOr types.str;
                description = "Path to local socket";
                default = null;
              };
              master = mkOption {
                type = types.nullOr (types.listOf types.str);
                description = "List of master servers or a single DNS SRV record of at least 1 master server, prepended with dnssrv+";
                default = null;
              };
              maxMB = mkOption {
                type = types.nullOr types.str;
                description = "Split files larger than the limit";
                default = null;
              };
              metricsIp = mkOption {
                type = types.nullOr types.str;
                description = "Metrics listen ip";
                default = null;
              };
              metricsPort = mkOption {
                type = types.nullOr types.port;
                description = "Prometheus metrics listen port";
                default = null;
              };
              options = mkOption {
                type = types.nullOr types.port;
                description = "Path to a file of command line options, each line in optionName=optionValue format";
                default = null;
              };
              port = mkOption {
                type = types.nullOr types.port;
                description = "Filer server http listen port";
                default = null;
              };
              portGrpc = mkOption {
                type = types.nullOr types.port;
                description = "Filer server gRPC listen port";
                default = null;
              };
              portReadonly = mkOption {
                type = types.nullOr types.port;
                description = "Readonly port opened to public";
                default = null;
              };
              rack = mkOption {
                type = types.nullOr types.str;
                description = "Prefer to write to volumes in this rack";
                default = null;
              };
              s3 = mkOption {
                description = "Options related to s3";
                default = {};
                type = with types;
                  submodule {
                    options = {
                      enable = mkOption {
                        type = types.nullOr types.bool;
                        description = "Whether to enable the s3 gateway";
                        default = null;
                      };
                      allowDeleteBucketNotEmpty = mkOption {
                        type = types.nullOr types.bool;
                        description = "Allow recursive deleting all entries along with bucket";
                        default = null;
                      };
                      allowEmptyFolder = mkOption {
                        type = types.nullOr types.bool;
                        description = "Allow empty folders";
                        default = null;
                      };
                      allowedOrigins = mkOption {
                        type = types.nullOr (types.listOf types.str);
                        description = "List of allowed origins";
                        default = null;
                      };
                      auditLogConfig = mkOption {
                        type = types.nullOr types.str;
                        description = "Filer server http listen ip address";
                        default = null;
                      };
                      cacertFile = mkOption {
                        type = types.nullOr types.str;
                        description = "Path to the TLS CA certificate file";
                        default = null;
                      };
                      certFile = mkOption {
                        type = types.nullOr types.str;
                        description = "Path to the TLS certificate file";
                        default = null;
                      };
                      config = mkOption {
                        type = types.nullOr types.str;
                        description = "path to the config file";
                        default = null;
                      };
                      dataCenter = mkOption {
                        type = types.nullOr types.str;
                        description = "Prefer to read and write to volumes in this data center";
                        default = null;
                      };
                      domainName = mkOption {
                        type = types.nullOr (types.listOf types.str);
                        description = "List of suffixes of the host name";
                        default = null;
                      };
                      idleTimeout = mkOption {
                        type = types.nullOr types.ints.positive;
                        description = "Connection idle seconds";
                        default = null;
                      };
                      ipBind = mkOption {
                        type = types.nullOr types.str;
                        description = "Ip address to bind to";
                        default = null;
                      };
                      keyFile = mkOption {
                        type = types.nullOr types.str;
                        description = "Path to the TLS private key file";
                        default = null;
                      };
                      localSocket = mkOption {
                        type = types.nullOr types.str;
                        description = "Path to local socket";
                        default = null;
                      };
                      port = mkOption {
                        type = types.nullOr types.port;
                        description = "S3 server http listen port";
                        default = null;
                      };
                      portGrpc = mkOption {
                        type = types.nullOr types.port;
                        description = "S3 server gRPC listen port";
                        default = null;
                      };
                      portHttps = mkOption {
                        type = types.nullOr types.port;
                        description = "S3 server https listen port";
                        default = null;
                      };
                      tlsVerifyClientCert = mkOption {
                        type = types.nullOr types.bool;
                        description = "Whether to verify the client's certificate";
                        default = null;
                      };
                    };
                  };
              };
              saveToFilerLimit = mkOption {
                type = types.nullOr types.ints.positive;
                description = "Files smaller than this limit will be saved in filer store";
                default = null;
              };
              sftp = mkOption {
                description = "Options related to SFTP";
                default = {};
                type = with types;
                  submodule {
                    options = {
                      enable = mkOption {
                        type = types.nullOr types.bool;
                        description = "Whether to enable the SFTP server";
                        default = null;
                      };
                      authMethods = mkOption {
                        type = types.nullOr (types.listOf types.str);
                        description = "List of allowed auth methods: password, publickey, keyboard-interactive";
                        default = null;
                      };
                      bannerMessage = mkOption {
                        type = types.nullOr types.str;
                        description = "Message displayed before authentication";
                        default = null;
                      };
                      clientAliveCountMax = mkOption {
                        type = types.nullOr types.ints.positive;
                        description = "Maximum number of missed keep-alive messages before disconnecting";
                        default = null;
                      };
                      clientAliveInterval = mkOption {
                        type = types.nullOr types.ints.positive;
                        description = "Interval for sending keep-alive messages";
                        default = null;
                      };
                      dataCenter = mkOption {
                        type = types.nullOr types.str;
                        description = "Prefer to read and write to volumes in this data center";
                        default = null;
                      };
                      hostKeysFolder = mkOption {
                        type = types.nullOr types.str;
                        description = "Path to folder containing SSH private key files for host authentication";
                        default = null;
                      };
                      ipBind = mkOption {
                        type = types.nullOr types.str;
                        description = "Prefer to read and write to volumes in this data center";
                        default = null;
                      };
                      localSocket = mkOption {
                        type = types.nullOr types.str;
                        description = "Path to local socket";
                        default = null;
                      };
                      loginGraceTime = mkOption {
                        type = types.nullOr types.str;
                        description = "Timeout for authentication, in the format of <hour>h<min>m<sec>s";
                        default = null;
                      };
                      maxAuthTries = mkOption {
                        type = types.nullOr types.ints.positive;
                        description = "Maximum number of authentication attempts per connection";
                        default = null;
                      };
                      port = mkOption {
                        type = types.nullOr types.port;
                        description = "SFTP server listen port";
                        default = null;
                      };
                      sshPrivateKey = mkOption {
                        type = types.nullOr types.str;
                        description = "Path to the SSH private key file for host authentication";
                        default = null;
                      };
                      userStoreFile = mkOption {
                        type = types.nullOr types.str;
                        description = "Path to JSON file containing user credentials and permissions";
                        default = null;
                      };
                    };
                  };
              };
              uiDeleteDir = mkOption {
                type = types.nullOr types.bool;
                description = "Enable filer UI show delete directory button";
                default = null;
              };
              webdav = mkOption {
                description = "Options related to webdav";
                default = {};
                type = with types;
                  submodule {
                    options = {
                      enable = mkOption {
                        type = types.nullOr types.bool;
                        description = "Whether to enable the webdav gateway";
                        default = null;
                      };
                      cacheCapacityMB = mkOption {
                        type = types.nullOr types.ints.positive;
                        description = "Local cache capacity in MB";
                        default = null;
                      };
                      cacheDir = mkOption {
                        type = types.nullOr types.str;
                        description = "Local cache directory for file chunks";
                        default = null;
                      };
                      certFile = mkOption {
                        type = types.nullOr types.str;
                        description = "Path to the TLS certificate file";
                        default = null;
                      };
                      collection = mkOption {
                        type = types.nullOr types.str;
                        description = "Collection to create the files";
                        default = null;
                      };
                      disk = mkOption {
                        type = types.nullOr types.str;
                        description = "[hdd|ssd|<tag>] hard drive or solid state drive or any tag";
                        default = null;
                      };
                      filerPath = mkOption {
                        type = types.nullOr types.str;
                        description = "Use this remote path from filer server";
                        default = null;
                      };
                      keyFile = mkOption {
                        type = types.nullOr types.str;
                        description = "Path to the TLS private key file";
                        default = null;
                      };
                      maxMB = mkOption {
                        type = types.nullOr types.ints.positive;
                        description = "Split files larger than the limit";
                        default = null;
                      };
                      port = mkOption {
                        type = types.nullOr types.port;
                        description = "Webdav server http listen port";
                        default = null;
                      };
                      replication = mkOption {
                        type = types.nullOr types.str;
                        description = "Replication to create the files";
                        default = null;
                      };
                    };
                  };
              };
            };
          };
      };
      volume = mkOption {
        description = "Options related to the seaweedfs volume";
        default = {};
        type = with types;
          submodule {
            options = {
              enable = mkEnableOption "The seaweedfs volume service";
              compactionMBps = mkOption {
                type = types.nullOr types.ints.positive;
                description = "Limit background compaction or copying speed in mega bytes per second";
                default = null;
              };
              concurrentDownloadLimitMB = mkOption {
                type = types.nullOr types.ints.positive;
                description = "limit total concurrent download size";
                default = null;
              };
              concurrentUploadLimitMB = mkOption {
                type = types.nullOr types.ints.positive;
                description = "Limit total concurrent upload size";
                default = null;
              };
              cpuprofile = mkOption {
                type = types.nullOr types.str;
                description = "CPU profile output file";
                default = null;
              };
              dataCenter = mkOption {
                type = types.nullOr types.str;
                description = "Current volume server's data center name";
                default = null;
              };
              dir = mkOption {
                type = types.nullOr (types.listOf types.str);
                description = "Directories to store data files";
                default = null;
              };
              dirIdx = mkOption {
                type = types.nullOr types.str;
                description = "Directory to store .idx files";
                default = null;
              };
              disk = mkOption {
                type = types.nullOr types.str;
                description = "[hdd|ssd|<tag>] hard drive or solid state drive or any tag";
                default = null;
              };
              fileSizeLimitMB = mkOption {
                type = types.nullOr types.ints.positive;
                description = "Limit file size to avoid out of memory";
                default = null;
              };
              hasSlowRead = mkOption {
                type = types.nullOr types.bool;
                description = "If true, this prevents slow reads from blocking other requests, but large file read P99 latency will increase";
                default = null;
              };
              idleTimeout = mkOption {
                type = types.nullOr types.ints.positive;
                description = "Connection idle seconds";
                default = null;
              };
              imagesFixOrientation = mkOption {
                type = types.nullOr types.bool;
                description = "Adjust jpg orientation when uploading";
                default = null;
              };
              index = mkOption {
                type = types.nullOr types.str;
                description = "Choose [memory|leveldb|leveldbMedium|leveldbLarge] mode for memory~performance balance";
                default = null;
              };
              indexLeveldbTimeout = mkOption {
                type = types.nullOr types.ints.positive;
                description = "Alive time for leveldb (default to 0). If leveldb of volume is not accessed in ldbTimeout hours, it will be off loaded to reduce opened files and memory consumption";
                default = null;
              };
              inflightDownloadDataTimeout = mkOption {
                type = types.nullOr types.str;
                description = "Inflight download data wait timeout of volume servers in format of <hours>h<minutes>m<seconds>s";
                default = null;
              };
              inflightUploadDataTimeout = mkOption {
                type = types.nullOr types.str;
                description = "Inflight upload data wait timeout of volume servers in format of <hours>h<minutes>m<seconds>s";
                default = null;
              };
              ip = mkOption {
                type = types.nullOr types.str;
                description = "Ip or server name, also used as identifier";
                default = null;
              };
              ipBind = mkOption {
                type = types.nullOr types.str;
                description = "Ip address to bind to";
                default = null;
              };
              max = mkOption {
                type = types.nullOr types.str;
                description = "maximum numbers of volumes, count[,count]... If set to zero, the limit will be auto configured as free disk space divided by volume size";
                default = null;
              };
              memprofile = mkOption {
                type = types.nullOr types.str;
                description = "Memory profile output file";
                default = null;
              };
              metricsIp = mkOption {
                type = types.nullOr types.str;
                description = "Metrics listen Ip";
                default = null;
              };
              metricsPort = mkOption {
                type = types.nullOr types.port;
                description = "Prometheus metrics listen port";
                default = null;
              };
              minFreeSpace = mkOption {
                type = types.nullOr types.str;
                description = "Min free disk space (value<=100 as percentage like 1, other as human readable bytes, like 10GiB). Low disk space will mark all volumes as ReadOnly";
                default = null;
              };
              mserver = mkOption {
                type = types.nullOr (types.listOf types.str);
                description = "List of master servers";
                default = null;
              };
              options = mkOption {
                type = types.nullOr types.port;
                description = "Path to a file of command line options, each line in optionName=optionValue format";
                default = null;
              };
              port = mkOption {
                type = types.nullOr types.port;
                description = "HTTP listen port";
                default = null;
              };
              portGrpc = mkOption {
                type = types.nullOr types.port;
                description = "gRPC listen port";
                default = null;
              };
              portPublic = mkOption {
                type = types.nullOr types.port;
                description = "Port opened to public";
                default = null;
              };
              pprof = mkOption {
                type = types.nullOr types.bool;
                description = "Enable pprof http handlers";
                default = null;
              };
              preStopSeconds = mkOption {
                type = types.nullOr types.ints.positive;
                description = "Number of seconds between stop send heartbeats and stop volume server";
                default = null;
              };
              publicUrl = mkOption {
                type = types.nullOr types.str;
                description = "Publicly accessible address";
                default = null;
              };
              rack = mkOption {
                type = types.nullOr types.str;
                description = "Current volume server's rack name";
                default = null;
              };
              readBufferSizeMB = mkOption {
                type = types.nullOr types.ints.positive;
                description = "Larger values can optimize query performance but will increase some memory usage,Use with hasSlowRead normally";
                default = null;
              };
              readMode = mkOption {
                type = types.nullOr types.str;
                description = "[local|proxy|redirect] how to deal with non-local volume: 'not found|proxy to remote node|redirect volume location'";
                default = null;
              };
              whiteList = mkOption {
                type = types.nullOr (types.listOf types.str);
                description = "List of Ip addresses having write permission";
                default = null;
              };
            };
          };
      };
    };
    config = let
      optNotNull = nullableValue: value: optional (nullableValue != null) value;
      configDerivation =
        if cfg.config != null
        then
          pkgs.runCommand "seaweedfs-cfg" {} ''
            mkdir -p $out

            ${concatStringsSep "\n" (
              mapAttrsToList (name: content: ''
                cat > $out/${name} << 'EOF'
                ${content}
                EOF
              '')
              cfg.config
            )}
          ''
        else null;
      generalArgs =
        []
        ++ optNotNull configDerivation "-config_dir ${configDerivation}";
      generalArgsString = join " " generalArgs;
    in {
      systemd.services.seaweedfs-master = let
        mCfg = cfg.master;
        args =
          []
          ++ optNotNull mCfg.cpuProfile "-cpuprofile ${mCfg.cpuProfile}"
          ++ optNotNull mCfg.defaultReplication "-defaultReplication ${mCfg.defaultReplication}"
          ++ optNotNull mCfg.disableHttp "-disableHttp"
          ++ optNotNull mCfg.electionTimeout "-electionTimeout ${toString mCfg.electionTimeout}"
          ++ optNotNull mCfg.garbageThreshold "-garbageThreshold ${toString mCfg.garbageThreshold}"
          ++ optNotNull mCfg.heartbeatInterval "-heartbeatInterval ${toString mCfg.heartbeatInterval}"
          ++ optNotNull mCfg.ip "-ip ${mCfg.ip}"
          ++ optNotNull mCfg.ipBind "-ip.bind ${mCfg.ipBind}"
          ++ optNotNull mCfg.maxParallelVacuumPerServer "-maxParallelVacuumPerServer ${toString mCfg.maxParallelVacuumPerServer}"
          ++ optNotNull mCfg.mdir "-mdir ${mCfg.mdir}"
          ++ optNotNull mCfg.memProfile "-memprofile ${mCfg.memProfile}"
          ++ optNotNull mCfg.metricsAddress "-metrics.address ${mCfg.metricsAddress}"
          ++ optNotNull mCfg.metricsIntervalSeconds "-metrics.intervalSeconds ${toString mCfg.metricsIntervalSeconds}"
          ++ optNotNull mCfg.metricsIp "-metricsIp ${mCfg.metricsIp}"
          ++ optNotNull mCfg.metricsPort "-metricsPort ${toString mCfg.metricsPort}"
          ++ optNotNull mCfg.peers "-peers ${join "," mCfg.peers}"
          ++ optNotNull mCfg.port "-port ${toString mCfg.port}"
          ++ optNotNull mCfg.portGrpc "-port.grpc ${toString mCfg.portGrpc}"
          ++ optNotNull mCfg.raftBootstrap "-raftBootstrap"
          ++ optNotNull mCfg.raftHashicorp "-raftHashicorp"
          ++ optNotNull mCfg.resumeState "-resumeState"
          ++ optNotNull mCfg.telemetry "-telemetry"
          ++ optNotNull mCfg.telemetryUrl "-telemetryUrl ${mCfg.telemetryUrl}"
          ++ optNotNull mCfg.volumePreallocate "-volumePreallocate ${mCfg.volumePreallocate}"
          ++ optNotNull mCfg.volumeSizeLimitMB "-volumeSizeLimitMB ${toString mCfg.volumeSizeLimitMB}"
          ++ optNotNull mCfg.whiteList "-whitelist ${mCfg.whiteList}";
        argsString = join " " args;
      in
        mkIf cfg.master.enable
        rec {
          wantedBy = ["multi-user.target"];
          after = ["network-online.target"];
          wants = after;
          description = "SeaweedFS master service";
          serviceConfig = {
            Type = "simple";
            ExecStart = "${cfg.package}/bin/weed ${generalArgsString} master ${argsString}";
          };
        };
      systemd.services.seaweedfs-filer = let
        fCfg = cfg.filer;
        args =
          []
          ++ optNotNull fCfg.allowedOrigins "-allowedOrigins ${join "," fCfg.allowedOrigins}"
          ++ optNotNull fCfg.collection "-collection ${fCfg.collection}"
          ++ optNotNull fCfg.concurrentUploadLimitMB "-concurrentUploadLimitMB ${toString cfg.concurrentUploadLimitMB}"
          ++ optNotNull fCfg.concurrentDownloadLimitMB "-concurrentDownloadLimitMB ${toString fCfg.concurrentDownloadLimitMB}"
          ++ optNotNull fCfg.dataCenter "-dataCenter ${fCfg.dataCenter}"
          ++ optNotNull fCfg.debug "-debug"
          ++ optNotNull fCfg.debugPort "-debug.port ${toString fCfg.debugPort}"
          ++ optNotNull fCfg.defaultReplicaPlacement "-defaultReplicaPlacement ${fCfg.defaultReplicaPlacement}"
          ++ optNotNull fCfg.defaultStoreDir "-defaultStoreDir ${fCfg.defaultStoreDir}"
          ++ optNotNull fCfg.dirListLimit "-dirListLimit ${toString fCfg.dirListLimit}"
          ++ optNotNull fCfg.disableDirListing "-disableDirListing"
          ++ optNotNull fCfg.disableHttp "-disableHttp"
          ++ optNotNull fCfg.disk "-disk ${fCfg.disk}"
          ++ optNotNull fCfg.downloadMaxMBps "-downloadMaxMBps ${toString fCfg.downloadMaxMBps}"
          ++ optNotNull fCfg.encryptVolumeData "-encryptVolumeData"
          ++ optNotNull fCfg.exposeDirectoryData "-exposeDirectoryData"
          ++ optNotNull fCfg.filerGroup "-filerGroup ${fCfg.filerGroup}"
          ++ optNotNull fCfg.iam.enable "-iam"
          ++ optNotNull fCfg.iam.ip "-iam.ip ${fCfg.iam.ip}"
          ++ optNotNull fCfg.iam.port "-iam.port ${toString fCfg.iam.port}"
          ++ optNotNull fCfg.ip "-ip ${fCfg.ip}"
          ++ optNotNull fCfg.ipBind "-ip.bind ${fCfg.ipBind}"
          ++ optNotNull fCfg.localSocket "-localSocket ${fCfg.localSocket}"
          ++ optNotNull fCfg.master "-master ${join "," fCfg.master}"
          ++ optNotNull fCfg.maxMB "-maxMB ${toString fCfg.maxMB}"
          ++ optNotNull fCfg.metricsIp "-metricsIp ${fCfg.metricsIp}"
          ++ optNotNull fCfg.metricsPort "-metricsPort ${toString fCfg.metricsPort}"
          ++ optNotNull fCfg.options "-options ${fCfg.options}"
          ++ optNotNull fCfg.port "-port ${toString fCfg.port}"
          ++ optNotNull fCfg.portGrpc "-port.grpc ${toString fCfg.portGrpc}"
          ++ optNotNull fCfg.portReadonly "-port.readonly ${toString fCfg.portReadonly}"
          ++ optNotNull fCfg.rack "-rack ${fCfg.rack}"
          ++ optNotNull fCfg.s3.enable "-s3"
          ++ optNotNull fCfg.s3.allowDeleteBucketNotEmpty "-allowDeleteBucketNotEmpty"
          ++ optNotNull fCfg.s3.allowEmptyFolder "-allowEmptyFolder"
          ++ optNotNull fCfg.s3.allowedOrigins "-allowedOrigins"
          ++ optNotNull fCfg.s3.auditLogConfig "-auditLogConfig ${fCfg.s3.auditLogConfig}"
          ++ optNotNull fCfg.s3.cacertFile "-s3.cacert.file ${fCfg.s3.cacertFile}"
          ++ optNotNull fCfg.s3.certFile "-s3.cert.file ${fCfg.certFile}"
          ++ optNotNull fCfg.s3.config "-s3.config ${fCfg.s3.config}"
          ++ optNotNull fCfg.s3.dataCenter "-s3.dateCenter ${fCfg.s3.dataCenter}"
          ++ optNotNull fCfg.s3.domainName "-s3.domainName ${fCfg.s3.domainName}"
          ++ optNotNull fCfg.s3.idleTimeout "-s3.idleTimeout ${toString fCfg.s3.idleTimeout}"
          ++ optNotNull fCfg.s3.ipBind "-s3.ip.bind ${fCfg.s3.ipBind}"
          ++ optNotNull fCfg.s3.keyFile "-s3.key.file ${fCfg.s3.keyFile}"
          ++ optNotNull fCfg.s3.localSocket "-s3.localSocket ${fCfg.s3.localSocket}"
          ++ optNotNull fCfg.s3.port "-s3.port ${toString fCfg.s3.Port}"
          ++ optNotNull fCfg.s3.portGrpc "-s3.port.grpc ${fCfg.s3.portGrpc}"
          ++ optNotNull fCfg.s3.portHttps "-s3.port.https ${fCfg.s3.portHttps}"
          ++ optNotNull fCfg.s3.tlsVerifyClientCert "-tlsVerifyClientCert"
          ++ optNotNull fCfg.saveToFilerLimit "-saveToFilerLimit ${toString fCfg.saveToFilerLimit}"
          ++ optNotNull fCfg.sftp.enable "-sftp"
          ++ optNotNull fCfg.sftp.authMethods "-sftp.authMethods ${fCfg.sftp.authMethods}"
          ++ optNotNull fCfg.sftp.bannerMessage "-sftp.bannerMessage ${fCfg.sftp.bannerMessage}"
          ++ optNotNull fCfg.sftp.clientAliveCountMax "-sftp.clientAliveCountMax ${toString fCfg.sftp.clientAliveCountMax}"
          ++ optNotNull fCfg.sftp.clientAliveInterval "-sftp.clientAliveInterval ${toString fCfg.sftp.clientAliveInterval}"
          ++ optNotNull fCfg.sftp.dataCenter "-sftp.dataCenter ${fCfg.sftp.dataCenter}"
          ++ optNotNull fCfg.sftp.hostKeysFolder "-sftp.hostKeysFolder ${fCfg.sftp.hostKeysFolder}"
          ++ optNotNull fCfg.sftp.ipBind "-sftp.ip.bind ${fCfg.sftp.ipBind}"
          ++ optNotNull fCfg.sftp.localSocket "-sftp.localSocket ${fCfg.sftp.localSocket}"
          ++ optNotNull fCfg.sftp.loginGraceTime "-sftp.loginGraceTime ${toString fCfg.sftp.loginGraceTime}"
          ++ optNotNull fCfg.sftp.maxAuthTries "-sftp.maxAuthTries ${toString fCfg.sftp.maxAuthTries}"
          ++ optNotNull fCfg.sftp.port "-sftp.port ${toString fCfg.sftp.port}"
          ++ optNotNull fCfg.sftp.sshPrivateKey "-sftp.sshPrivateKey ${fCfg.sftp.sshPrivateKey}"
          ++ optNotNull fCfg.sftp.userStoreFile "-sftp.userStoreFile ${fCfg.sftp.userStoreFile}"
          ++ optNotNull fCfg.uiDeleteDir "-ui.deleteDir ${fCfg.uiDeleteDir}"
          ++ optNotNull fCfg.webdav.enable "-webdav"
          ++ optNotNull fCfg.webdav.cacheCapacityMB "-webdav.cacheCapacityMB ${toString fCfg.webdav.cacheCapacityMB}"
          ++ optNotNull fCfg.webdav.cacheDir "-webdav.cacheDir ${fCfg.webdav.cacheDir}"
          ++ optNotNull fCfg.webdav.certFile "-webdav.cert.file ${fCfg.webdav.certFile}"
          ++ optNotNull fCfg.webdav.collection "-webdav.collection ${fCfg.webdav.collection}"
          ++ optNotNull fCfg.webdav.disk "-webdav.disk ${fCfg.webdav.disk}"
          ++ optNotNull fCfg.webdav.filerPath "-webdav.filer.path ${fCfg.webdav.filerPath}"
          ++ optNotNull fCfg.webdav.keyFile "-webdav.key.file ${fCfg.webdav.keyFile}"
          ++ optNotNull fCfg.webdav.maxMB "-webdav.maxMB ${toString fCfg.webdav.maxMB}"
          ++ optNotNull fCfg.webdav.port "-webdav.port ${toString fCfg.webdav.port}"
          ++ optNotNull fCfg.webdav.replication "-webdav.replication ${fCfg.webdav.replication}";
        argsString = join " " args;
      in
        mkIf cfg.filer.enable
        rec {
          wantedBy = ["multi-user.target"];
          after = ["network-online.target"];
          wants = after;
          description = "SeaweedFS filer service";
          serviceConfig = {
            Type = "simple";
            ExecStart = "${cfg.package}/bin/weed ${generalArgsString} filer ${argsString}";
          };
        };
      systemd.services.seaweedfs-volume = let
        vCfg = cfg.volume;
        args =
          []
          ++ optNotNull vCfg.compactionMBps "-compactionMBps ${toString vCfg.compactionMBps}"
          ++ optNotNull vCfg.concurrentDownloadLimitMB "-concurrentDownloadLimitMB ${toString vCfg.concurrentDownloadLimitMB}"
          ++ optNotNull vCfg.concurrentUploadLimitMB "-concurrentUploadLimitMB ${toString vCfg.concurrentUploadLimitMB}"
          ++ optNotNull vCfg.cpuprofile "-cpuprofile ${vCfg.cpuprofile}"
          ++ optNotNull vCfg.dataCenter "-dataCenter ${vCfg.dataCenter}"
          ++ optNotNull vCfg.dir "-dir ${join "," vCfg.dir}"
          ++ optNotNull vCfg.dirIdx "-dir.idx ${vCfg.dirIdx}"
          ++ optNotNull vCfg.disk "-disk ${vCfg.disk}"
          ++ optNotNull vCfg.fileSizeLimitMB "-fileSizeLimitMB ${toString vCfg.fileSizeLimitMB}"
          ++ optNotNull vCfg.hasSlowRead "-hasSlowRead"
          ++ optNotNull vCfg.idleTimeout "-idleTimeout ${toString vCfg.idleTimeout}"
          ++ optNotNull vCfg.imagesFixOrientation "-images.fix.orientation"
          ++ optNotNull vCfg.index "-index ${vCfg.index}"
          ++ optNotNull vCfg.indexLeveldbTimeout "-index.leveldbTimeout ${toString vCfg.indexLeveldbTimeout}"
          ++ optNotNull vCfg.inflightDownloadDataTimeout "-inflightDownloadDataTimeout ${vCfg.inflightDownloadDataTimeout}"
          ++ optNotNull vCfg.inflightUploadDataTimeout "-inflightUploadDataTimeout ${vCfg.inflightUploadDataTimeout}"
          ++ optNotNull vCfg.ip "-ip ${vCfg.ip}"
          ++ optNotNull vCfg.ipBind "-ip.bind ${vCfg.ipBind}"
          ++ optNotNull vCfg.max "-max ${toString vCfg.max}"
          ++ optNotNull vCfg.memprofile "-memprofile ${vCfg.memprofile}"
          ++ optNotNull vCfg.metricsIp "-metricsIp ${vCfg.metricsIp}"
          ++ optNotNull vCfg.metricsPort "-metricsPort ${toString vCfg.metricsPort}"
          ++ optNotNull vCfg.minFreeSpace "-minFreeSpace ${vCfg.minFreeSpace}"
          ++ optNotNull vCfg.mserver "-mserver ${join "," vCfg.mserver}"
          ++ optNotNull vCfg.options "-options ${vCfg.options}"
          ++ optNotNull vCfg.port "-port ${toString vCfg.port}"
          ++ optNotNull vCfg.portGrpc "-port.grpc ${toString vCfg.portGrpc}"
          ++ optNotNull vCfg.portPublic "-port.public ${toString vCfg.portPublic}"
          ++ optNotNull vCfg.pprof "-pprof"
          ++ optNotNull vCfg.preStopSeconds "-preStopSeconds ${toString vCfg.preStopSeconds}"
          ++ optNotNull vCfg.publicUrl "-publicUrl ${vCfg.publicUrl}"
          ++ optNotNull vCfg.rack "-rack ${vCfg.rack}"
          ++ optNotNull vCfg.readBufferSizeMB "-readBufferSizeMB ${toString vCfg.readBufferSizeMB}";
        argsString = join " " args;
      in
        mkIf cfg.volume.enable
        rec {
          wantedBy = ["multi-user.target"];
          after = ["network-online.target"];
          wants = after;
          description = "SeaweedFS volume service";
          serviceConfig = {
            Type = "simple";
            ExecStart = "${cfg.package}/bin/weed ${generalArgsString} volume ${argsString}";
          };
        };
    };
  }
