// lib/main.dart
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef JsonMap = Map<String, dynamic>;
typedef HeaderMap = Map<String, String>;

const String kXyloFont = 'BlackOpsOne';

class _XyloHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    HttpOverrides.global = _XyloHttpOverrides();
  }
  runApp(const XyloTechSolutionAdminApp());
}

// ============================================================================
// 🌟 THEME & COLORS (XYLOTECHSOLUTION.COM CYBER GOLD & BLACK OPS ONE)
// ============================================================================
class XyloThemeColors {
  static const Color bgDeep = Color(0xFF090805);
  static const Color surfaceGlass = Color(0xD8120E06);
  static const Color surfaceCard = Color(0xCC181308);
  static const Color surfaceInput = Color(0xE60F0C05);
  static const Color gold = Color(0xFFF5B800);
  static const Color goldBright = Color(0xFFFFD84D);
  static const Color borderGold = Color(0x77F5B800);
  static const Color borderSubtle = Color(0x38F5B800);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFE2D9C8);
  static const Color textMuted = Color(0xFF9E927E);
  static const Color emerald = Color(0xFF10B981);
  static const Color crimson = Color(0xFFEF4444);
  static const Color sky = Color(0xFF0EA5E9);
}

class XyloTechSolutionAdminApp extends StatelessWidget {
  const XyloTechSolutionAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData.dark(useMaterial3: true);
    return MaterialApp(
      title: 'xylotechsolution admin',
      debugShowCheckedModeBanner: false,
      theme: baseTheme.copyWith(
        scaffoldBackgroundColor: XyloThemeColors.bgDeep,
        textTheme: baseTheme.textTheme.apply(
          fontFamily: kXyloFont,
          bodyColor: XyloThemeColors.textPrimary,
          displayColor: XyloThemeColors.textPrimary,
        ),
        primaryTextTheme: baseTheme.primaryTextTheme.apply(
          fontFamily: kXyloFont,
        ),
        colorScheme: const ColorScheme.dark(
          primary: XyloThemeColors.gold,
          secondary: XyloThemeColors.goldBright,
          surface: XyloThemeColors.surfaceCard,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: XyloThemeColors.surfaceInput,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          hintStyle: const TextStyle(
            fontFamily: kXyloFont,
            color: XyloThemeColors.textMuted,
            fontSize: 12.5,
          ),
          labelStyle: const TextStyle(
            fontFamily: kXyloFont,
            color: XyloThemeColors.goldBright,
            fontSize: 12.5,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: XyloThemeColors.borderSubtle),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: XyloThemeColors.gold, width: 1.8),
          ),
        ),
      ),
      home: const XyloAdminRootScreen(),
    );
  }
}

// ============================================================================
// 🌟 LIVE ANIMATED BACKGROUND (GOLDEN PARTICLE WAVE VIDEO REPLICA)
// ============================================================================
class XyloGoldenHorizonBackground extends StatefulWidget {
  final Widget child;
  const XyloGoldenHorizonBackground({super.key, required this.child});

  @override
  State<XyloGoldenHorizonBackground> createState() =>
      _XyloGoldenHorizonBackgroundState();
}

class _XyloGoldenHorizonBackgroundState
    extends State<XyloGoldenHorizonBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  final List<_RisingBeam> _beams = [];
  final List<_SparkDot> _sparks = [];

  @override
  void initState() {
    super.initState();
    final rng = math.Random(42);
    for (int i = 0; i < 68; i++) {
      _beams.add(
        _RisingBeam(
          xFraction: rng.nextDouble(),
          speed: 0.12 + rng.nextDouble() * 0.35,
          phase: rng.nextDouble(),
          length: 0.12 + rng.nextDouble() * 0.32,
          thickness: 1.0 + rng.nextDouble() * 1.8,
          brightness: 0.35 + rng.nextDouble() * 0.65,
        ),
      );
    }
    for (int i = 0; i < 95; i++) {
      _sparks.add(
        _SparkDot(
          xFraction: rng.nextDouble(),
          yFraction: rng.nextDouble(),
          size: 1.0 + rng.nextDouble() * 2.5,
          speed: 0.05 + rng.nextDouble() * 0.18,
          alpha: 0.2 + rng.nextDouble() * 0.7,
        ),
      );
    }
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedBuilder(
          animation: _animController,
          builder: (context, _) {
            return CustomPaint(
              painter: _GoldenHorizonWavePainter(
                progress: _animController.value,
                beams: _beams,
                sparks: _sparks,
              ),
            );
          },
        ),
        widget.child,
      ],
    );
  }
}

class _RisingBeam {
  final double xFraction;
  final double speed;
  final double phase;
  final double length;
  final double thickness;
  final double brightness;

  const _RisingBeam({
    required this.xFraction,
    required this.speed,
    required this.phase,
    required this.length,
    required this.thickness,
    required this.brightness,
  });
}

class _SparkDot {
  final double xFraction;
  final double yFraction;
  final double size;
  final double speed;
  final double alpha;

  const _SparkDot({
    required this.xFraction,
    required this.yFraction,
    required this.size,
    required this.speed,
    required this.alpha,
  });
}

class _GoldenHorizonWavePainter extends CustomPainter {
  final double progress;
  final List<_RisingBeam> beams;
  final List<_SparkDot> sparks;

  _GoldenHorizonWavePainter({
    required this.progress,
    required this.beams,
    required this.sparks,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final bgPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF0A0804),
          Color(0xFF171104),
          Color(0xFF281C05),
          Color(0xFF0E0A03),
        ],
        stops: [0.0, 0.55, 0.80, 1.0],
      ).createShader(rect);
    canvas.drawRect(rect, bgPaint);

    final horizonY = size.height * 0.78;

    final flareCenter = Offset(size.width * 0.5, horizonY);
    final flarePaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFE57F).withValues(alpha: 0.55),
          const Color(0xFFF5B800).withValues(alpha: 0.25),
          Colors.transparent,
        ],
        stops: const [0.0, 0.38, 1.0],
      ).createShader(
        Rect.fromCircle(center: flareCenter, radius: size.width * 0.45),
      );
    canvas.drawRect(rect, flarePaint);

    for (final b in beams) {
      final t = (b.phase + progress * b.speed * 3.0) % 1.0;
      final x = b.xFraction * size.width;
      final headY = horizonY - (t * horizonY * 0.96);
      final tailY = math.min(horizonY, headY + size.height * b.length);

      if (tailY <= headY) continue;

      final fadeOut = (1.0 - t).clamp(0.0, 1.0);
      final alpha = (b.brightness * fadeOut).clamp(0.0, 1.0);

      final streakPaint = Paint()
        ..strokeWidth = b.thickness
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFFFF3B0).withValues(alpha: alpha),
            const Color(0xFFF5B800).withValues(alpha: alpha * 0.65),
            Colors.transparent,
          ],
        ).createShader(Rect.fromPoints(Offset(x, headY), Offset(x, tailY)));

      canvas.drawLine(Offset(x, headY), Offset(x, tailY), streakPaint);

      final headGlow = Paint()
        ..color = const Color(0xFFFFF5C0).withValues(alpha: alpha);
      canvas.drawCircle(Offset(x, headY), b.thickness * 1.35, headGlow);
    }

    for (final s in sparks) {
      final yShift = (s.yFraction - progress * s.speed) % 1.0;
      final py = (yShift < 0 ? yShift + 1.0 : yShift) * horizonY;
      final px = s.xFraction * size.width;
      final p = Paint()
        ..color = const Color(0xFFFFD54F).withValues(alpha: s.alpha * 0.55);
      canvas.drawCircle(Offset(px, py), s.size, p);
    }

    const int waveRows = 14;
    const int cols = 64;
    for (int r = 0; r < waveRows; r++) {
      final rowFrac = r / (waveRows - 1);
      final baseRowY = horizonY + rowFrac * (size.height - horizonY);
      for (int c = 0; c <= cols; c++) {
        final colFrac = c / cols;
        final x = colFrac * size.width;
        final waveOffset = math.sin(
                  (colFrac * math.pi * 5.0) +
                      (progress * math.pi * 2.0) +
                      (r * 0.45),
                ) *
                (6.0 + rowFrac * 10.0) +
            math.cos((colFrac * math.pi * 3.0) - (progress * math.pi * 2.0)) *
                4.0;
        final y = baseRowY + waveOffset;
        final dotAlpha = (0.22 + (1.0 - rowFrac) * 0.55).clamp(0.1, 0.85);
        final dotPaint = Paint()
          ..color = const Color(0xFFF5B800).withValues(alpha: dotAlpha);
        canvas.drawCircle(Offset(x, y), 1.2 + rowFrac * 1.1, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _GoldenHorizonWavePainter oldDelegate) => true;
}

// ============================================================================
// 🌟 CONTROLLER FOR XYLOTECHSOLUTION ADMIN CRUD & AUTH
// ============================================================================
class XyloTechAdminController extends ChangeNotifier {
  bool isAuthenticated = false;
  String adminEmail = 'hasibsk1606@gmail.com';
  String adminName = 'Main SuperAdmin';
  String apiBaseUrl = 'https://shop.xylotechsolution.com';
  String? jwtAccessToken;

  bool isLoading = false;
  String? errorMessage;

  List<JsonMap> testimonials = [];
  List<JsonMap> services = [];
  List<JsonMap> processSteps = [];
  List<JsonMap> projects = [];
  List<JsonMap> blogs = [];

  HeaderMap get _jsonHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (jwtAccessToken != null && jwtAccessToken!.isNotEmpty)
          'Authorization': 'Bearer $jwtAccessToken',
      };

  Future<void> initSavedSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedUrl = prefs.getString('xylo_admin_api_url');
      final savedEmail = prefs.getString('xylo_admin_email');
      final savedToken = prefs.getString('xylo_admin_jwt');
      if (savedUrl != null && savedUrl.isNotEmpty) {
        apiBaseUrl = savedUrl;
      }
      if (savedEmail != null && savedEmail.isNotEmpty) {
        adminEmail = savedEmail;
      }
      if (savedToken != null && savedToken.isNotEmpty) {
        jwtAccessToken = savedToken;
      }
      notifyListeners();
    } catch (_) {}
  }

  String _cleanBaseUrl(String raw) {
    var s = raw.trim().replaceAll(RegExp(r'/$'), '');
    if (s.isNotEmpty && !s.startsWith('http://') && !s.startsWith('https://')) {
      s = 'https://$s';
    }
    return s;
  }

  String resolveMediaUrl(dynamic raw) {
    if (raw == null) return '';
    final str = raw.toString().trim();
    if (str.isEmpty || str == 'null') return '';
    if (str.startsWith('http://') ||
        str.startsWith('https://') ||
        str.startsWith('data:')) {
      return str;
    }
    final cleanBase = _cleanBaseUrl(apiBaseUrl);
    if (str.startsWith('/')) {
      return '$cleanBase$str';
    }
    return '$cleanBase/media/$str';
  }

  Future<String?> loginAsSuperUser({
    required String email,
    required String password,
    required String serverUrl,
    bool directAllowAnyMode = false,
  }) async {
    apiBaseUrl = _cleanBaseUrl(serverUrl);
    final cleanEmail = email.trim().toLowerCase();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('xylo_admin_api_url', apiBaseUrl);
      if (cleanEmail.isNotEmpty) {
        await prefs.setString('xylo_admin_email', cleanEmail);
      }
    } catch (_) {}

    if (directAllowAnyMode) {
      final err = await _verifyXylotechApiReachable();
      if (err != null) {
        return err;
      }
      isAuthenticated = true;
      await fetchAllModules();
      notifyListeners();
      return null;
    }

    if (cleanEmail.isEmpty || password.isEmpty) {
      return 'Superuser ইমেইল এবং পাসওয়ার্ড দিন।';
    }

    final loginEndpoints = [
      '$apiBaseUrl/api/v1/superadmin/auth/login/',
      '$apiBaseUrl/api/v1/auth/merchant-login/',
      '$apiBaseUrl/api/v1/auth/login/',
    ];

    String? lastError;

    for (final ep in loginEndpoints) {
      try {
        final resp = await http
            .post(
              Uri.parse(ep),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
              body: jsonEncode({
                'email': cleanEmail,
                'username': cleanEmail,
                'password': password,
              }),
            )
            .timeout(const Duration(seconds: 12));

        if (resp.statusCode == 200) {
          final data = jsonDecode(resp.body);
          final token = (data['access'] ?? '').toString();
          if (token.isNotEmpty) {
            jwtAccessToken = token;
            adminEmail = cleanEmail;
            adminName =
                (data['user']?['name'] ?? data['user']?['full_name'] ?? 'Admin')
                    .toString();
            isAuthenticated = true;
            try {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('xylo_admin_jwt', token);
            } catch (_) {}
            await fetchAllModules();
            notifyListeners();
            return null;
          }
        } else if (resp.statusCode == 401 || resp.statusCode == 403) {
          try {
            final data = jsonDecode(resp.body);
            lastError =
                (data['error'] ?? data['detail'] ?? 'ভুল ইমেইল বা পাসওয়ার্ড।')
                    .toString();
          } catch (_) {
            lastError = 'ভুল ইমেইল বা পাসওয়ার্ড (HTTP ${resp.statusCode})।';
          }
        }
      } catch (e) {
        lastError = e.toString();
      }
    }

    final reachErr = await _verifyXylotechApiReachable();
    if (reachErr == null && lastError == null) {
      isAuthenticated = true;
      await fetchAllModules();
      notifyListeners();
      return null;
    }

    return lastError ??
        reachErr ??
        'সার্ভারের সাথে কানেক্ট করা যাচ্ছে না ($apiBaseUrl)।';
  }

  Future<String?> _verifyXylotechApiReachable() async {
    try {
      final resp = await http
          .get(
            Uri.parse('$apiBaseUrl/api/v1/xylotech/services/?admin=1'),
            headers: _jsonHeaders,
          )
          .timeout(const Duration(seconds: 10));
      if (resp.statusCode >= 200 && resp.statusCode < 500) {
        return null;
      }
      return 'সার্ভার রেসপন্স এরর (HTTP ${resp.statusCode})।';
    } catch (e) {
      return 'নেটওয়ার্ক কানেকশন ব্যর্থ হয়েছে ($apiBaseUrl): $e';
    }
  }

  void logout() async {
    isAuthenticated = false;
    jwtAccessToken = null;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('xylo_admin_jwt');
    } catch (_) {}
    notifyListeners();
  }

  List<JsonMap> _extractList(dynamic decoded) {
    if (decoded is List) {
      return decoded.whereType().map((e) => JsonMap.from(e)).toList();
    }
    if (decoded is Map && decoded['results'] is List) {
      return (decoded['results'] as List)
          .whereType()
          .map((e) => JsonMap.from(e))
          .toList();
    }
    return [];
  }

  Future<void> fetchAllModules() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        http.get(
            Uri.parse('$apiBaseUrl/api/v1/xylotech/testimonials/?admin=1'),
            headers: _jsonHeaders),
        http.get(Uri.parse('$apiBaseUrl/api/v1/xylotech/services/?admin=1'),
            headers: _jsonHeaders),
        http.get(
            Uri.parse('$apiBaseUrl/api/v1/xylotech/process-steps/?admin=1'),
            headers: _jsonHeaders),
        http.get(Uri.parse('$apiBaseUrl/api/v1/xylotech/projects/?admin=1'),
            headers: _jsonHeaders),
        http.get(Uri.parse('$apiBaseUrl/api/v1/xylotech/blogs/?admin=1'),
            headers: _jsonHeaders),
      ]).timeout(const Duration(seconds: 15));

      if (results[0].statusCode == 200) {
        testimonials = _extractList(jsonDecode(results[0].body));
      }
      if (results[1].statusCode == 200) {
        services = _extractList(jsonDecode(results[1].body));
      }
      if (results[2].statusCode == 200) {
        processSteps = _extractList(jsonDecode(results[2].body));
      }
      if (results[3].statusCode == 200) {
        projects = _extractList(jsonDecode(results[3].body));
      }
      if (results[4].statusCode == 200) {
        blogs = _extractList(jsonDecode(results[4].body));
      }
    } catch (e) {
      errorMessage = 'ডাটা লোড করতে সমস্যা হয়েছে: $e';
    }

    isLoading = false;
    notifyListeners();
  }

  Future<String?> saveModelRecord({
    required String endpoint,
    String? recordIdentifier,
    required JsonMap fields,
    String? imageFilePath,
    Uint8List? imageBytes,
    String? imageFileName,
  }) async {
    final isEdit = recordIdentifier != null && recordIdentifier.isNotEmpty;
    final url = isEdit
        ? '$apiBaseUrl/api/v1/xylotech/$endpoint/$recordIdentifier/'
        : '$apiBaseUrl/api/v1/xylotech/$endpoint/';

    try {
      final hasImageFile = (imageFilePath != null && imageFilePath.isNotEmpty) ||
          (imageBytes != null && imageBytes.isNotEmpty);

      http.Response response;

      if (hasImageFile) {
        final req = http.MultipartRequest(
          isEdit ? 'PATCH' : 'POST',
          Uri.parse(url),
        );
        if (jwtAccessToken != null && jwtAccessToken!.isNotEmpty) {
          req.headers['Authorization'] = 'Bearer $jwtAccessToken';
        }
        fields.forEach((key, val) {
          if (val == null) return;
          if (val is List || val is Map) {
            req.fields[key] = jsonEncode(val);
          } else {
            req.fields[key] = val.toString();
          }
        });

        if (imageBytes != null && imageBytes.isNotEmpty) {
          req.files.add(
            http.MultipartFile.fromBytes(
              'image',
              imageBytes,
              filename: imageFileName ?? 'upload.jpg',
            ),
          );
        } else if (imageFilePath != null && imageFilePath.isNotEmpty) {
          req.files
              .add(await http.MultipartFile.fromPath('image', imageFilePath));
        }

        final streamed = await req.send().timeout(const Duration(seconds: 25));
        response = await http.Response.fromStream(streamed);
      } else {
        response = isEdit
            ? await http
                .patch(
                  Uri.parse(url),
                  headers: _jsonHeaders,
                  body: jsonEncode(fields),
                )
                .timeout(const Duration(seconds: 15))
            : await http
                .post(
                  Uri.parse(url),
                  headers: _jsonHeaders,
                  body: jsonEncode(fields),
                )
                .timeout(const Duration(seconds: 15));
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        await fetchAllModules();
        return null;
      } else {
        return 'সেভ করা যায়নি (HTTP ${response.statusCode}): ${response.body}';
      }
    } catch (e) {
      return 'নেটওয়ার্ক এরর: $e';
    }
  }

  Future<String?> deleteModelRecord({
    required String endpoint,
    required String recordIdentifier,
  }) async {
    final url = '$apiBaseUrl/api/v1/xylotech/$endpoint/$recordIdentifier/';
    try {
      final resp = await http
          .delete(Uri.parse(url), headers: _jsonHeaders)
          .timeout(const Duration(seconds: 12));
      if (resp.statusCode >= 200 && resp.statusCode < 300) {
        await fetchAllModules();
        return null;
      }
      return 'ডিলিট করা যায়নি (HTTP ${resp.statusCode}): ${resp.body}';
    } catch (e) {
      return 'ডিলিট এরর: $e';
    }
  }
}

// ============================================================================
// 🌟 ROOT SCREEN
// ============================================================================
class XyloAdminRootScreen extends StatefulWidget {
  const XyloAdminRootScreen({super.key});

  @override
  State<XyloAdminRootScreen> createState() => _XyloAdminRootScreenState();
}

class _XyloAdminRootScreenState extends State<XyloAdminRootScreen> {
  final XyloTechAdminController _controller = XyloTechAdminController();

  @override
  void initState() {
    super.initState();
    _controller.initSavedSession();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        return XyloGoldenHorizonBackground(
          child: _controller.isAuthenticated
              ? XyloTechAdminShell(controller: _controller)
              : XyloSuperAdminLoginScreen(controller: _controller),
        );
      },
    );
  }
}

// ============================================================================
// 🌟 XYLOSUPERADMIN STYLE LOGIN SCREEN (WITH BLACK OPS ONE FONT)
// ============================================================================
class XyloSuperAdminLoginScreen extends StatefulWidget {
  final XyloTechAdminController controller;
  const XyloSuperAdminLoginScreen({super.key, required this.controller});

  @override
  State<XyloSuperAdminLoginScreen> createState() =>
      _XyloSuperAdminLoginScreenState();
}

class _XyloSuperAdminLoginScreenState extends State<XyloSuperAdminLoginScreen> {
  late TextEditingController _emailCtrl;
  final TextEditingController _passCtrl = TextEditingController();
  late TextEditingController _urlCtrl;
  bool _obscure = true;
  bool _submitting = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _emailCtrl = TextEditingController(text: widget.controller.adminEmail);
    _urlCtrl = TextEditingController(text: widget.controller.apiBaseUrl);
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _urlCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleLogin({bool directAllowAny = false}) async {
    setState(() {
      _submitting = true;
      _error = null;
    });
    final err = await widget.controller.loginAsSuperUser(
      email: _emailCtrl.text,
      password: _passCtrl.text,
      serverUrl: _urlCtrl.text,
      directAllowAnyMode: directAllowAny,
    );
    if (mounted) {
      setState(() {
        _submitting = false;
        _error = err;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                  child: Container(
                    padding: const EdgeInsets.all(26),
                    decoration: BoxDecoration(
                      color: XyloThemeColors.surfaceCard,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                          color: XyloThemeColors.borderGold, width: 1.5),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 54,
                              height: 54,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    XyloThemeColors.goldBright,
                                    XyloThemeColors.gold,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                'X',
                                style: TextStyle(
                                  fontFamily: kXyloFont,
                                  color: Colors.black,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '[01] SOFTWARE • SAAS • AI',
                                    style: TextStyle(
                                      fontFamily: kXyloFont,
                                      color: XyloThemeColors.gold,
                                      fontSize: 11,
                                      letterSpacing: 1.3,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'XYLO TECH\nMASTER ADMIN',
                                    style: TextStyle(
                                      fontFamily: kXyloFont,
                                      color: XyloThemeColors.textPrimary,
                                      fontSize: 22,
                                      height: 1.12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: XyloThemeColors.gold.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: XyloThemeColors.borderSubtle),
                          ),
                          child: const Text(
                            'XYLOTECHSOLUTION.COM OFFICIAL CMS STUDIO — TESTIMONIALS • SERVICES • PROCESS • PROJECTS • BLOGS',
                            style: TextStyle(
                              fontFamily: kXyloFont,
                              color: XyloThemeColors.textSecondary,
                              fontSize: 11.5,
                              height: 1.4,
                            ),
                          ),
                        ),
                        if (_error != null) ...[
                          const SizedBox(height: 14),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: XyloThemeColors.crimson
                                  .withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: XyloThemeColors.crimson),
                            ),
                            child: SelectableText(
                              _error!,
                              style: const TextStyle(
                                fontFamily: kXyloFont,
                                color: Color(0xFFFCA5A5),
                                fontSize: 11.5,
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 18),
                        TextField(
                          controller: _emailCtrl,
                          style: const TextStyle(fontFamily: kXyloFont),
                          decoration: const InputDecoration(
                            labelText: 'SUPERUSER EMAIL',
                            prefixIcon: Icon(
                                Icons.admin_panel_settings_rounded,
                                color: XyloThemeColors.gold),
                          ),
                        ),
                        const SizedBox(height: 14),
                        TextField(
                          controller: _passCtrl,
                          obscureText: _obscure,
                          style: const TextStyle(fontFamily: kXyloFont),
                          onSubmitted: (_) => _handleLogin(),
                          decoration: InputDecoration(
                            labelText: 'SUPERUSER PASSWORD',
                            prefixIcon: const Icon(Icons.key_rounded,
                                color: XyloThemeColors.gold),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscure
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_rounded,
                                color: XyloThemeColors.textSecondary,
                              ),
                              onPressed: () =>
                                  setState(() => _obscure = !_obscure),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        TextField(
                          controller: _urlCtrl,
                          style: const TextStyle(fontFamily: kXyloFont),
                          decoration: const InputDecoration(
                            labelText: 'DJANGO BACKEND URL',
                            prefixIcon: Icon(Icons.dns_rounded,
                                color: XyloThemeColors.gold),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          children: [
                            ActionChip(
                              backgroundColor: XyloThemeColors.surfaceInput,
                              side: const BorderSide(
                                  color: XyloThemeColors.borderGold),
                              label: const Text(
                                'LIVE DOMAIN (HTTPS)',
                                style: TextStyle(
                                  fontFamily: kXyloFont,
                                  fontSize: 10.5,
                                  color: XyloThemeColors.goldBright,
                                ),
                              ),
                              onPressed: () => setState(() => _urlCtrl.text =
                                  'https://shop.xylotechsolution.com'),
                            ),
                            ActionChip(
                              backgroundColor: XyloThemeColors.surfaceInput,
                              side: const BorderSide(
                                  color: XyloThemeColors.borderSubtle),
                              label: const Text(
                                'LOCALHOST (8000)',
                                style: TextStyle(
                                  fontFamily: kXyloFont,
                                  fontSize: 10.5,
                                ),
                              ),
                              onPressed: () => setState(() =>
                                  _urlCtrl.text = 'http://localhost:8000'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: XyloThemeColors.gold,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed:
                                _submitting ? null : () => _handleLogin(),
                            icon: _submitting
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2.2,
                                        color: Colors.black),
                                  )
                                : const Icon(Icons.bolt_rounded),
                            label: const Text(
                              'LOGIN AS SUPERUSER',
                              style: TextStyle(
                                fontFamily: kXyloFont,
                                fontSize: 14,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: XyloThemeColors.borderGold),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: _submitting
                                ? null
                                : () => _handleLogin(directAllowAny: true),
                            icon: const Icon(Icons.rocket_launch_rounded,
                                size: 16, color: XyloThemeColors.goldBright),
                            label: const Text(
                              'QUICK CONNECT (PUBLIC API MODE)',
                              style: TextStyle(
                                fontFamily: kXyloFont,
                                color: XyloThemeColors.goldBright,
                                fontSize: 11.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// 🌟 MAIN ADMIN SHELL (SAFEAREA + GLASSMORPHIC SIDEBAR + BLACK OPS ONE)
// ============================================================================
class XyloTechAdminShell extends StatefulWidget {
  final XyloTechAdminController controller;
  const XyloTechAdminShell({super.key, required this.controller});

  @override
  State<XyloTechAdminShell> createState() => _XyloTechAdminShellState();
}

class _XyloTechAdminShellState extends State<XyloTechAdminShell> {
  int _selectedIndex = 0;
  String _searchQuery = '';

  static const _navItems = [
    ('OVERVIEW STUDIO', Icons.dashboard_customize_rounded, '00'),
    ('TESTIMONIALS', Icons.format_quote_rounded, '01'),
    ('SERVICES', Icons.layers_rounded, '02'),
    ('PROCESS STEPS', Icons.account_tree_rounded, '03'),
    ('PROJECTS', Icons.workspaces_rounded, '04'),
    ('BLOG POSTS', Icons.article_rounded, '05'),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 940;

    return Scaffold(
      backgroundColor: Colors.transparent,
      drawer: isDesktop
          ? null
          : Drawer(
              backgroundColor: XyloThemeColors.bgDeep,
              child: _buildSidebar(isDrawer: true),
            ),
      bottomNavigationBar: isDesktop
          ? null
          : Container(
              decoration: const BoxDecoration(
                color: XyloThemeColors.surfaceGlass,
                border:
                    Border(top: BorderSide(color: XyloThemeColors.borderGold)),
              ),
              child: NavigationBar(
                height: 66,
                backgroundColor: Colors.transparent,
                indicatorColor: XyloThemeColors.gold,
                selectedIndex: _selectedIndex,
                onDestinationSelected: (i) =>
                    setState(() => _selectedIndex = i),
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.dashboard_rounded),
                    selectedIcon:
                        Icon(Icons.dashboard_rounded, color: Colors.black),
                    label: 'ALL',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.format_quote_rounded),
                    selectedIcon:
                        Icon(Icons.format_quote_rounded, color: Colors.black),
                    label: 'REVIEWS',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.layers_rounded),
                    selectedIcon:
                        Icon(Icons.layers_rounded, color: Colors.black),
                    label: 'SERVICES',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.account_tree_rounded),
                    selectedIcon:
                        Icon(Icons.account_tree_rounded, color: Colors.black),
                    label: 'STEPS',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.workspaces_rounded),
                    selectedIcon:
                        Icon(Icons.workspaces_rounded, color: Colors.black),
                    label: 'PROJECTS',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.article_rounded),
                    selectedIcon:
                        Icon(Icons.article_rounded, color: Colors.black),
                    label: 'BLOGS',
                  ),
                ],
              ),
            ),
      body: SafeArea(
        child: Row(
          children: [
            if (isDesktop)
              SizedBox(width: 280, child: _buildSidebar(isDrawer: false)),
            Expanded(
              child: Column(
                children: [
                  _buildTopBar(isDesktop: isDesktop),
                  Expanded(child: _buildMainContent()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebar({required bool isDrawer}) {
    final c = widget.controller;
    final counts = [
      c.testimonials.length +
          c.services.length +
          c.processSteps.length +
          c.projects.length +
          c.blogs.length,
      c.testimonials.length,
      c.services.length,
      c.processSteps.length,
      c.projects.length,
      c.blogs.length,
    ];

    return Material(
      color: XyloThemeColors.surfaceGlass,
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(color: XyloThemeColors.borderGold),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            XyloThemeColors.goldBright,
                            XyloThemeColors.gold,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'X',
                        style: TextStyle(
                          fontFamily: kXyloFont,
                          color: Colors.black,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'XYLOTECH',
                            style: TextStyle(
                              fontFamily: kXyloFont,
                              fontSize: 16,
                              color: XyloThemeColors.textPrimary,
                              letterSpacing: 1.0,
                            ),
                          ),
                          Text(
                            '[01] ADMIN STUDIO',
                            style: TextStyle(
                              fontFamily: kXyloFont,
                              fontSize: 10,
                              color: XyloThemeColors.gold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: XyloThemeColors.borderSubtle),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _navItems.length,
                  itemBuilder: (context, i) {
                    final item = _navItems[i];
                    final sel = _selectedIndex == i;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: ListTile(
                        selected: sel,
                        selectedTileColor:
                            XyloThemeColors.gold.withValues(alpha: 0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: sel
                                ? XyloThemeColors.gold
                                : XyloThemeColors.borderSubtle,
                          ),
                        ),
                        leading: Icon(
                          item.$2,
                          color: sel
                              ? XyloThemeColors.goldBright
                              : XyloThemeColors.textSecondary,
                        ),
                        title: Text(
                          item.$1,
                          style: TextStyle(
                            fontFamily: kXyloFont,
                            color: sel
                                ? XyloThemeColors.goldBright
                                : XyloThemeColors.textPrimary,
                            fontSize: 12.5,
                          ),
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: sel
                                ? XyloThemeColors.gold
                                : XyloThemeColors.bgDeep,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${counts[i]}',
                            style: TextStyle(
                              fontFamily: kXyloFont,
                              color:
                                  sel ? Colors.black : XyloThemeColors.gold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() => _selectedIndex = i);
                          if (isDrawer) Navigator.of(context).pop();
                        },
                      ),
                    );
                  },
                ),
              ),
              const Divider(height: 1, color: XyloThemeColors.borderSubtle),
              ListTile(
                leading: const Icon(Icons.logout_rounded,
                    color: XyloThemeColors.crimson),
                title: Text(
                  c.adminEmail,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontFamily: kXyloFont, fontSize: 11.5),
                ),
                subtitle: Text(
                  c.apiBaseUrl,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontFamily: kXyloFont,
                      color: XyloThemeColors.gold,
                      fontSize: 10),
                ),
                onTap: c.logout,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar({required bool isDesktop}) {
    final c = widget.controller;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: const BoxDecoration(
        color: XyloThemeColors.surfaceGlass,
        border: Border(bottom: BorderSide(color: XyloThemeColors.borderGold)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (!isDesktop)
                Builder(
                  builder: (ctx) => IconButton(
                    icon: const Icon(Icons.menu_rounded,
                        color: XyloThemeColors.gold),
                    onPressed: () => Scaffold.of(ctx).openDrawer(),
                  ),
                ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: XyloThemeColors.gold.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: XyloThemeColors.gold),
                ),
                child: Text(
                  '[${_navItems[_selectedIndex].$3}]',
                  style: const TextStyle(
                    fontFamily: kXyloFont,
                    color: XyloThemeColors.goldBright,
                    fontSize: 11,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _navItems[_selectedIndex].$1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: kXyloFont,
                    fontSize: 16,
                    color: XyloThemeColors.textPrimary,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              if (isDesktop) ...[
                SizedBox(
                  width: 260,
                  height: 38,
                  child: TextField(
                    onChanged: (v) => setState(() => _searchQuery = v),
                    style:
                        const TextStyle(fontFamily: kXyloFont, fontSize: 12),
                    decoration: InputDecoration(
                      hintText: 'SEARCH ITEMS...',
                      prefixIcon: const Icon(Icons.search_rounded,
                          size: 18, color: XyloThemeColors.gold),
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              IconButton(
                tooltip: 'SYNC LIVE',
                onPressed: c.fetchAllModules,
                icon:
                    const Icon(Icons.sync_rounded, color: XyloThemeColors.gold),
              ),
              if (_selectedIndex > 0)
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: XyloThemeColors.gold,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => _openFormForSection(_selectedIndex),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text(
                    'ADD NEW',
                    style: TextStyle(fontFamily: kXyloFont, fontSize: 11.5),
                  ),
                ),
            ],
          ),
          if (!isDesktop) ...[
            const SizedBox(height: 8),
            SizedBox(
              height: 38,
              child: TextField(
                onChanged: (v) => setState(() => _searchQuery = v),
                style: const TextStyle(fontFamily: kXyloFont, fontSize: 12),
                decoration: InputDecoration(
                  hintText: 'SEARCH TESTIMONIALS, SERVICES, PROJECTS, BLOGS...',
                  prefixIcon: const Icon(Icons.search_rounded,
                      size: 18, color: XyloThemeColors.gold),
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    final c = widget.controller;
    if (c.isLoading &&
        c.testimonials.isEmpty &&
        c.services.isEmpty &&
        c.projects.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: XyloThemeColors.gold),
      );
    }

    switch (_selectedIndex) {
      case 0:
        return _buildAllSectionsOverviewList();
      case 1:
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [_buildTestimonialsListSection()],
        );
      case 2:
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [_buildServicesListSection()],
        );
      case 3:
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [_buildProcessStepsListSection()],
        );
      case 4:
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [_buildProjectsListSection()],
        );
      case 5:
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [_buildBlogsListSection()],
        );
      default:
        return _buildAllSectionsOverviewList();
    }
  }

  // Responsive 2-Column Mobile / 5-Column Desktop Luxury Grid + All List-Down Sections
  Widget _buildAllSectionsOverviewList() {
    final c = widget.controller;
    final cardsData = [
      (
        '[01]',
        'TESTIMONIALS',
        c.testimonials.length,
        Icons.format_quote_rounded,
        () => _openTestimonialModal(),
        1
      ),
      (
        '[02]',
        'SERVICES',
        c.services.length,
        Icons.layers_rounded,
        () => _openServiceModal(),
        2
      ),
      (
        '[03]',
        'PROCESS STEPS',
        c.processSteps.length,
        Icons.account_tree_rounded,
        () => _openProcessStepModal(),
        3
      ),
      (
        '[04]',
        'PROJECTS',
        c.projects.length,
        Icons.workspaces_rounded,
        () => _openProjectModal(),
        4
      ),
      (
        '[05]',
        'BLOG POSTS',
        c.blogs.length,
        Icons.article_rounded,
        () => _openBlogModal(),
        5
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final cols = constraints.maxWidth >= 1100
                ? 5
                : (constraints.maxWidth >= 700 ? 3 : 2);
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cardsData.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                mainAxisExtent: 138,
              ),
              itemBuilder: (context, idx) {
                final item = cardsData[idx];
                return _StatSummaryCard(
                  tag: item.$1,
                  title: item.$2,
                  count: item.$3,
                  icon: item.$4,
                  onAdd: item.$5,
                  onTap: () => setState(() => _selectedIndex = item.$6),
                );
              },
            );
          },
        ),
        const SizedBox(height: 20),
        _buildTestimonialsListSection(),
        const SizedBox(height: 20),
        _buildServicesListSection(),
        const SizedBox(height: 20),
        _buildProcessStepsListSection(),
        const SizedBox(height: 20),
        _buildProjectsListSection(),
        const SizedBox(height: 20),
        _buildBlogsListSection(),
      ],
    );
  }

  void _openFormForSection(int idx) {
    if (idx == 1) _openTestimonialModal();
    if (idx == 2) _openServiceModal();
    if (idx == 3) _openProcessStepModal();
    if (idx == 4) _openProjectModal();
    if (idx == 5) _openBlogModal();
  }

  bool _matchesSearch(String text) {
    final q = _searchQuery.trim().toLowerCase();
    if (q.isEmpty) return true;
    return text.toLowerCase().contains(q);
  }

  // --------------------------------------------------------------------------
  // 1. TESTIMONIALS
  // --------------------------------------------------------------------------
  Widget _buildTestimonialsListSection() {
    final items = widget.controller.testimonials
        .where((e) => _matchesSearch('${e['name']} ${e['role']} ${e['text']}'))
        .toList();

    return _SectionListContainer(
      tag: '[01]',
      title: 'TESTIMONIALS (${items.length})',
      subtitle: 'MARQUEE ROW 1 & ROW 2 CLIENT FEEDBACK',
      onAddPressed: () => _openTestimonialModal(),
      children: items.map((item) {
        final id = item['id'].toString();
        final active = item['is_active'] != false;
        return _ListDownRowCard(
          leadingBadge: 'ROW ${item['row'] ?? 1}',
          title: '${item['name'] ?? ''} — ${item['role'] ?? ''}',
          subtitle: (item['text'] ?? '').toString(),
          metaText: 'ORDER: ${item['order'] ?? 0} • ID: #$id',
          isActive: active,
          onToggleActive: (val) => widget.controller.saveModelRecord(
            endpoint: 'testimonials',
            recordIdentifier: id,
            fields: {'is_active': val},
          ),
          onEdit: () => _openTestimonialModal(existing: item),
          onDelete: () => _confirmDelete(
            title: (item['name'] ?? 'Testimonial').toString(),
            endpoint: 'testimonials',
            identifier: id,
          ),
        );
      }).toList(),
    );
  }

  void _openTestimonialModal({JsonMap? existing}) {
    final nameCtrl =
        TextEditingController(text: (existing?['name'] ?? '').toString());
    final roleCtrl =
        TextEditingController(text: (existing?['role'] ?? '').toString());
    final textCtrl =
        TextEditingController(text: (existing?['text'] ?? '').toString());
    final orderCtrl =
        TextEditingController(text: (existing?['order'] ?? 0).toString());
    int rowVal = (existing?['row'] as num?)?.toInt() ?? 1;
    bool isActive = existing?['is_active'] != false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => _CrudFormDialog(
          title: existing == null ? 'ADD TESTIMONIAL' : 'EDIT TESTIMONIAL',
          onSave: () async {
            return await widget.controller.saveModelRecord(
              endpoint: 'testimonials',
              recordIdentifier: existing?['id']?.toString(),
              fields: {
                'name': nameCtrl.text.trim(),
                'role': roleCtrl.text.trim(),
                'text': textCtrl.text.trim(),
                'row': rowVal,
                'order': int.tryParse(orderCtrl.text.trim()) ?? 0,
                'is_active': isActive,
              },
            );
          },
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'CLIENT NAME *'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: roleCtrl,
              decoration: const InputDecoration(
                  labelText: 'ROLE / COMPANY (CEO, TECHCORP) *'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: textCtrl,
              maxLines: 3,
              decoration:
                  const InputDecoration(labelText: 'TESTIMONIAL QUOTE TEXT *'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              initialValue: rowVal,
              decoration: const InputDecoration(labelText: 'MARQUEE ROW'),
              items: const [
                DropdownMenuItem(value: 1, child: Text('ROW 1 (TOP MARQUEE)')),
                DropdownMenuItem(
                    value: 2, child: Text('ROW 2 (BOTTOM MARQUEE)')),
              ],
              onChanged: (v) => setModalState(() => rowVal = v ?? 1),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: orderCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'DISPLAY ORDER'),
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: isActive,
              activeThumbColor: XyloThemeColors.gold,
              title: const Text('ACTIVE ON WEBSITE',
                  style: TextStyle(fontFamily: kXyloFont, fontSize: 13)),
              onChanged: (v) => setModalState(() => isActive = v),
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // 2. SERVICES
  // --------------------------------------------------------------------------
  Widget _buildServicesListSection() {
    final items = widget.controller.services
        .where((e) =>
            _matchesSearch('${e['title']} ${e['description']} ${e['tags']}'))
        .toList();

    return _SectionListContainer(
      tag: '[02]',
      title: 'SERVICES (${items.length})',
      subtitle: 'CORE AGENCY & SAAS SERVICES WITH LUCIDE ICON',
      onAddPressed: () => _openServiceModal(),
      children: items.map((item) {
        final id = item['id'].toString();
        final tags = (item['tags'] is List)
            ? (item['tags'] as List).join(', ')
            : (item['tags'] ?? '').toString();
        final active = item['is_active'] != false;
        return _ListDownRowCard(
          leadingBadge: (item['icon_name'] ?? 'Globe').toString().toUpperCase(),
          title: (item['title'] ?? '').toString(),
          subtitle: (item['description'] ?? '').toString(),
          metaText:
              'SLUG: ${item['slug'] ?? ''} • TAGS: [$tags] • ORDER: ${item['order'] ?? 0}',
          isActive: active,
          onToggleActive: (val) => widget.controller.saveModelRecord(
            endpoint: 'services',
            recordIdentifier: id,
            fields: {'is_active': val},
          ),
          onEdit: () => _openServiceModal(existing: item),
          onDelete: () => _confirmDelete(
            title: (item['title'] ?? 'Service').toString(),
            endpoint: 'services',
            identifier: id,
          ),
        );
      }).toList(),
    );
  }

  void _openServiceModal({JsonMap? existing}) {
    final titleCtrl =
        TextEditingController(text: (existing?['title'] ?? '').toString());
    final slugCtrl =
        TextEditingController(text: (existing?['slug'] ?? '').toString());
    final descCtrl = TextEditingController(
        text: (existing?['description'] ?? '').toString());
    final iconCtrl = TextEditingController(
        text: (existing?['icon_name'] ?? 'Globe').toString());
    final existingTags = (existing?['tags'] is List)
        ? (existing!['tags'] as List).join(', ')
        : '';
    final tagsCtrl = TextEditingController(text: existingTags);
    final orderCtrl =
        TextEditingController(text: (existing?['order'] ?? 0).toString());
    bool isActive = existing?['is_active'] != false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => _CrudFormDialog(
          title: existing == null ? 'ADD SERVICE' : 'EDIT SERVICE',
          onSave: () async {
            final tagsList = tagsCtrl.text
                .split(',')
                .map((e) => e.trim())
                .where((e) => e.isNotEmpty)
                .toList();
            return await widget.controller.saveModelRecord(
              endpoint: 'services',
              recordIdentifier: existing?['id']?.toString(),
              fields: {
                'title': titleCtrl.text.trim(),
                if (slugCtrl.text.trim().isNotEmpty)
                  'slug': slugCtrl.text.trim(),
                'description': descCtrl.text.trim(),
                'icon_name': iconCtrl.text.trim(),
                'tags': tagsList,
                'order': int.tryParse(orderCtrl.text.trim()) ?? 0,
                'is_active': isActive,
              },
            );
          },
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(labelText: 'SERVICE TITLE *'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: iconCtrl,
              decoration: const InputDecoration(
                  labelText: 'LUCIDE ICON (Globe, Sparkles, Code, Brain) *'),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                'Globe',
                'Sparkles',
                'Code',
                'Brain',
                'Smartphone',
                'Shield',
                'Cpu',
                'Rocket'
              ]
                  .map((ic) => ActionChip(
                        backgroundColor: XyloThemeColors.surfaceInput,
                        side: const BorderSide(
                            color: XyloThemeColors.borderSubtle),
                        label: Text(ic,
                            style: const TextStyle(
                                fontFamily: kXyloFont, fontSize: 11)),
                        onPressed: () =>
                            setModalState(() => iconCtrl.text = ic),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: slugCtrl,
              decoration: const InputDecoration(
                  labelText: 'SLUG (AUTO IF LEFT BLANK)'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descCtrl,
              maxLines: 3,
              decoration:
                  const InputDecoration(labelText: 'SERVICE DESCRIPTION *'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: tagsCtrl,
              decoration: const InputDecoration(
                  labelText: 'TAGS (Next.js, Django, AI)'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: orderCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'DISPLAY ORDER'),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: isActive,
              activeThumbColor: XyloThemeColors.gold,
              title: const Text('ACTIVE ON WEBSITE',
                  style: TextStyle(fontFamily: kXyloFont, fontSize: 13)),
              onChanged: (v) => setModalState(() => isActive = v),
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // 3. PROCESS STEPS
  // --------------------------------------------------------------------------
  Widget _buildProcessStepsListSection() {
    final items = widget.controller.processSteps
        .where((e) => _matchesSearch('${e['title']} ${e['description']}'))
        .toList();

    return _SectionListContainer(
      tag: '[03]',
      title: 'PROCESS STEPS (${items.length})',
      subtitle: 'STEP-BY-STEP WORKFLOW CARDS WITH IMAGE & TAGS',
      onAddPressed: () => _openProcessStepModal(),
      children: items.map((item) {
        final id = item['id'].toString();
        final imgUrl = widget.controller.resolveMediaUrl(item['image']);
        final tags =
            (item['tags'] is List) ? (item['tags'] as List).join(', ') : '';
        final active = item['is_active'] != false;
        return _ListDownRowCard(
          leadingBadge:
              'STEP ${(item['formatted_id'] ?? item['step_number'] ?? '01')}',
          imageUrl: imgUrl,
          title: (item['title'] ?? '').toString(),
          subtitle: (item['description'] ?? '').toString(),
          metaText: 'TAGS: [$tags] • ORDER: ${item['order'] ?? 0}',
          isActive: active,
          onToggleActive: (val) => widget.controller.saveModelRecord(
            endpoint: 'process-steps',
            recordIdentifier: id,
            fields: {'is_active': val},
          ),
          onEdit: () => _openProcessStepModal(existing: item),
          onDelete: () => _confirmDelete(
            title: (item['title'] ?? 'Process Step').toString(),
            endpoint: 'process-steps',
            identifier: id,
          ),
        );
      }).toList(),
    );
  }

  void _openProcessStepModal({JsonMap? existing}) {
    final stepCtrl = TextEditingController(
        text: (existing?['step_number'] ??
                (widget.controller.processSteps.length + 1))
            .toString());
    final titleCtrl =
        TextEditingController(text: (existing?['title'] ?? '').toString());
    final descCtrl = TextEditingController(
        text: (existing?['description'] ?? '').toString());
    final existingTags = (existing?['tags'] is List)
        ? (existing!['tags'] as List).join(', ')
        : '';
    final tagsCtrl = TextEditingController(text: existingTags);
    final orderCtrl =
        TextEditingController(text: (existing?['order'] ?? 0).toString());
    bool isActive = existing?['is_active'] != false;
    String? pickedPath;
    Uint8List? pickedBytes;
    String? pickedName;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => _CrudFormDialog(
          title: existing == null ? 'ADD PROCESS STEP' : 'EDIT PROCESS STEP',
          onSave: () async {
            final tagsList = tagsCtrl.text
                .split(',')
                .map((e) => e.trim())
                .where((e) => e.isNotEmpty)
                .toList();
            return await widget.controller.saveModelRecord(
              endpoint: 'process-steps',
              recordIdentifier: existing?['id']?.toString(),
              fields: {
                'step_number': int.tryParse(stepCtrl.text.trim()) ?? 1,
                'title': titleCtrl.text.trim(),
                'description': descCtrl.text.trim(),
                'tags': tagsList,
                'order': int.tryParse(orderCtrl.text.trim()) ?? 0,
                'is_active': isActive,
              },
              imageFilePath: pickedPath,
              imageBytes: pickedBytes,
              imageFileName: pickedName,
            );
          },
          children: [
            TextField(
              controller: stepCtrl,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'STEP NUMBER (1, 2, 3...) *'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(labelText: 'STEP TITLE *'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descCtrl,
              maxLines: 3,
              decoration:
                  const InputDecoration(labelText: 'STEP DESCRIPTION *'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: tagsCtrl,
              decoration: const InputDecoration(
                  labelText: 'TAGS (Strategy, Architecture)'),
            ),
            const SizedBox(height: 12),
            _ImagePickerBox(
              currentImageUrl:
                  widget.controller.resolveMediaUrl(existing?['image']),
              pickedFileName: pickedName,
              onPicked: (path, bytes, name) {
                setModalState(() {
                  pickedPath = path;
                  pickedBytes = bytes;
                  pickedName = name;
                });
              },
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: isActive,
              activeThumbColor: XyloThemeColors.gold,
              title: const Text('ACTIVE ON WEBSITE',
                  style: TextStyle(fontFamily: kXyloFont, fontSize: 13)),
              onChanged: (v) => setModalState(() => isActive = v),
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // 4. PROJECTS
  // --------------------------------------------------------------------------
  Widget _buildProjectsListSection() {
    final items = widget.controller.projects
        .where((e) =>
            _matchesSearch('${e['title']} ${e['category']} ${e['stack']}'))
        .toList();

    return _SectionListContainer(
      tag: '[04]',
      title: 'PORTFOLIO PROJECTS (${items.length})',
      subtitle: 'SELECTED WORKS, CASE STUDIES & LIVE LINKS',
      onAddPressed: () => _openProjectModal(),
      children: items.map((item) {
        final id = item['id'].toString();
        final imgUrl = widget.controller.resolveMediaUrl(item['image']);
        final active = item['is_active'] != false;
        final featured = item['is_featured'] == true;
        return _ListDownRowCard(
          leadingBadge: (item['category'] ?? 'PROJECT').toString().toUpperCase(),
          imageUrl: imgUrl,
          title:
              '${item['title'] ?? ''} ${featured ? '★ FEATURED' : ''}'.trim(),
          subtitle: (item['stack'] ?? '').toString(),
          metaText:
              'BADGE: ${item['badge'] ?? '-'} • LIVE: ${item['live_link'] ?? '-'}',
          isActive: active,
          onToggleActive: (val) => widget.controller.saveModelRecord(
            endpoint: 'projects',
            recordIdentifier: id,
            fields: {'is_active': val},
          ),
          onEdit: () => _openProjectModal(existing: item),
          onDelete: () => _confirmDelete(
            title: (item['title'] ?? 'Project').toString(),
            endpoint: 'projects',
            identifier: id,
          ),
        );
      }).toList(),
    );
  }

  void _openProjectModal({JsonMap? existing}) {
    final titleCtrl =
        TextEditingController(text: (existing?['title'] ?? '').toString());
    final catCtrl =
        TextEditingController(text: (existing?['category'] ?? '').toString());
    final stackCtrl =
        TextEditingController(text: (existing?['stack'] ?? '').toString());
    final badgeCtrl =
        TextEditingController(text: (existing?['badge'] ?? '').toString());
    final linkCtrl =
        TextEditingController(text: (existing?['live_link'] ?? '').toString());
    final orderCtrl =
        TextEditingController(text: (existing?['order'] ?? 0).toString());
    bool isFeatured = existing?['is_featured'] == true;
    bool isActive = existing?['is_active'] != false;
    String? pickedPath;
    Uint8List? pickedBytes;
    String? pickedName;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => _CrudFormDialog(
          title: existing == null ? 'ADD PROJECT' : 'EDIT PROJECT',
          onSave: () async {
            return await widget.controller.saveModelRecord(
              endpoint: 'projects',
              recordIdentifier: existing?['id']?.toString(),
              fields: {
                'title': titleCtrl.text.trim(),
                'category': catCtrl.text.trim(),
                'stack': stackCtrl.text.trim(),
                'badge': badgeCtrl.text.trim(),
                'live_link': linkCtrl.text.trim(),
                'order': int.tryParse(orderCtrl.text.trim()) ?? 0,
                'is_featured': isFeatured,
                'is_active': isActive,
              },
              imageFilePath: pickedPath,
              imageBytes: pickedBytes,
              imageFileName: pickedName,
            );
          },
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(labelText: 'PROJECT TITLE *'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: catCtrl,
              decoration: const InputDecoration(
                  labelText: 'CATEGORY (SAAS, AI, FINTECH) *'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: stackCtrl,
              maxLines: 2,
              decoration: const InputDecoration(
                  labelText: 'TECH STACK / SUMMARY DESCRIPTION *'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: badgeCtrl,
              decoration: const InputDecoration(
                  labelText: 'BADGE (ENTERPRISE SAAS)'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: linkCtrl,
              decoration:
                  const InputDecoration(labelText: 'LIVE URL (https://...)'),
            ),
            const SizedBox(height: 12),
            _ImagePickerBox(
              currentImageUrl:
                  widget.controller.resolveMediaUrl(existing?['image']),
              pickedFileName: pickedName,
              onPicked: (path, bytes, name) {
                setModalState(() {
                  pickedPath = path;
                  pickedBytes = bytes;
                  pickedName = name;
                });
              },
            ),
            const SizedBox(height: 6),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: isFeatured,
              activeColor: XyloThemeColors.gold,
              checkColor: Colors.black,
              title: const Text('FEATURED PROJECT ON HOMEPAGE',
                  style: TextStyle(fontFamily: kXyloFont, fontSize: 12.5)),
              onChanged: (v) => setModalState(() => isFeatured = v ?? false),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: isActive,
              activeThumbColor: XyloThemeColors.gold,
              title: const Text('ACTIVE ON WEBSITE',
                  style: TextStyle(fontFamily: kXyloFont, fontSize: 12.5)),
              onChanged: (v) => setModalState(() => isActive = v),
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // 5. BLOG POSTS
  // --------------------------------------------------------------------------
  Widget _buildBlogsListSection() {
    final items = widget.controller.blogs
        .where((e) => _matchesSearch(
            '${e['title']} ${e['category']} ${e['description']}'))
        .toList();

    return _SectionListContainer(
      tag: '[05]',
      title: 'BLOG POSTS (${items.length})',
      subtitle: 'ARTICLES, TECHNICAL GUIDES & DYNAMIC BLOCKS',
      onAddPressed: () => _openBlogModal(),
      children: items.map((item) {
        final id = item['id'].toString();
        final imgUrl = widget.controller.resolveMediaUrl(item['image']);
        final published = item['is_published'] != false;
        return _ListDownRowCard(
          leadingBadge: (item['category'] ?? 'BLOG').toString().toUpperCase(),
          imageUrl: imgUrl,
          title: (item['title'] ?? '').toString(),
          subtitle: (item['description'] ?? '').toString(),
          metaText:
              '${item['read_time'] ?? '5 MIN READ'} • BADGE: ${item['badge'] ?? '-'}',
          isActive: published,
          onToggleActive: (val) => widget.controller.saveModelRecord(
            endpoint: 'blogs',
            recordIdentifier: id,
            fields: {'is_published': val},
          ),
          onEdit: () => _openBlogModal(existing: item),
          onDelete: () => _confirmDelete(
            title: (item['title'] ?? 'Blog Post').toString(),
            endpoint: 'blogs',
            identifier: id,
          ),
        );
      }).toList(),
    );
  }

  void _openBlogModal({JsonMap? existing}) {
    final titleCtrl =
        TextEditingController(text: (existing?['title'] ?? '').toString());
    final catCtrl = TextEditingController(
        text: (existing?['category'] ?? 'DEVELOPMENT').toString());
    final readCtrl = TextEditingController(
        text: (existing?['read_time'] ?? '5 MIN READ').toString());
    final badgeCtrl = TextEditingController(
        text: (existing?['badge'] ?? 'TECH INSIGHT').toString());
    final descCtrl = TextEditingController(
        text: (existing?['description'] ?? '').toString());
    final contentInit = existing?['content'] != null
        ? const JsonEncoder.withIndent('  ').convert(existing!['content'])
        : '[\n  {"type": "paragraph", "text": "Write your article content here..."}\n]';
    final contentCtrl = TextEditingController(text: contentInit);
    bool isPublished = existing?['is_published'] != false;
    String? pickedPath;
    Uint8List? pickedBytes;
    String? pickedName;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => _CrudFormDialog(
          title: existing == null ? 'ADD BLOG POST' : 'EDIT BLOG POST',
          onSave: () async {
            dynamic parsedContent = [];
            try {
              parsedContent = jsonDecode(contentCtrl.text.trim());
            } catch (_) {
              parsedContent = [
                {'type': 'paragraph', 'text': contentCtrl.text.trim()}
              ];
            }
            return await widget.controller.saveModelRecord(
              endpoint: 'blogs',
              recordIdentifier: existing?['id']?.toString(),
              fields: {
                'title': titleCtrl.text.trim(),
                'category': catCtrl.text.trim(),
                'read_time': readCtrl.text.trim(),
                'badge': badgeCtrl.text.trim(),
                'description': descCtrl.text.trim(),
                'content': parsedContent,
                'is_published': isPublished,
              },
              imageFilePath: pickedPath,
              imageBytes: pickedBytes,
              imageFileName: pickedName,
            );
          },
          children: [
            TextField(
              controller: titleCtrl,
              decoration:
                  const InputDecoration(labelText: 'BLOG POST TITLE *'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: catCtrl,
              decoration: const InputDecoration(
                  labelText: 'CATEGORY (STRATEGY / DEVELOPMENT) *'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: readCtrl,
                    decoration:
                        const InputDecoration(labelText: 'READ TIME'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: badgeCtrl,
                    decoration: const InputDecoration(labelText: 'BADGE'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descCtrl,
              maxLines: 2,
              decoration:
                  const InputDecoration(labelText: 'SHORT SUMMARY / EXCERPT *'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: contentCtrl,
              maxLines: 5,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              decoration: const InputDecoration(
                  labelText: 'CONTENT BLOCKS JSON (OR PLAIN TEXT)'),
            ),
            const SizedBox(height: 12),
            _ImagePickerBox(
              currentImageUrl:
                  widget.controller.resolveMediaUrl(existing?['image']),
              pickedFileName: pickedName,
              onPicked: (path, bytes, name) {
                setModalState(() {
                  pickedPath = path;
                  pickedBytes = bytes;
                  pickedName = name;
                });
              },
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: isPublished,
              activeThumbColor: XyloThemeColors.gold,
              title: const Text('PUBLISHED LIVE',
                  style: TextStyle(fontFamily: kXyloFont, fontSize: 13)),
              onChanged: (v) => setModalState(() => isPublished = v),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete({
    required String title,
    required String endpoint,
    required String identifier,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: XyloThemeColors.surfaceCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: XyloThemeColors.crimson),
        ),
        title: const Text('CONFIRM DELETE',
            style: TextStyle(
                fontFamily: kXyloFont, color: XyloThemeColors.crimson)),
        content: Text('আপনি কি নিশ্চিতভাবে "$title" ডিলিট করতে চান?',
            style: const TextStyle(fontFamily: kXyloFont, fontSize: 13)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('CANCEL',
                style: TextStyle(fontFamily: kXyloFont)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: XyloThemeColors.crimson,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              Navigator.of(ctx).pop();
              final err = await widget.controller.deleteModelRecord(
                endpoint: endpoint,
                recordIdentifier: identifier,
              );
              if (err != null && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: XyloThemeColors.crimson,
                    content: Text(err),
                  ),
                );
              }
            },
            child: const Text('DELETE NOW',
                style: TextStyle(fontFamily: kXyloFont)),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 🌟 LUXURY GLASSMORPHIC CARDS & FORM WIDGETS (WITH BLACK OPS ONE FONT)
// ============================================================================
class _StatSummaryCard extends StatelessWidget {
  final String tag;
  final String title;
  final int count;
  final IconData icon;
  final VoidCallback onAdd;
  final VoidCallback onTap;

  const _StatSummaryCard({
    required this.tag,
    required this.title,
    required this.count,
    required this.icon,
    required this.onAdd,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  XyloThemeColors.surfaceCard,
                  XyloThemeColors.gold.withValues(alpha: 0.12),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: XyloThemeColors.borderGold, width: 1.2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: XyloThemeColors.gold.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          fontFamily: kXyloFont,
                          color: XyloThemeColors.goldBright,
                          fontSize: 10.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(icon, color: XyloThemeColors.gold, size: 18),
                    const Spacer(),
                    InkWell(
                      onTap: onAdd,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          color: XyloThemeColors.gold,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add_rounded,
                            color: Colors.black, size: 18),
                      ),
                    ),
                  ],
                ),
                Text(
                  '$count',
                  style: const TextStyle(
                    fontFamily: kXyloFont,
                    fontSize: 30,
                    color: XyloThemeColors.textPrimary,
                    height: 1.0,
                  ),
                ),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: kXyloFont,
                    fontSize: 11.5,
                    color: XyloThemeColors.goldBright,
                    letterSpacing: 0.7,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionListContainer extends StatelessWidget {
  final String tag;
  final String title;
  final String subtitle;
  final VoidCallback onAddPressed;
  final List<Widget> children;

  const _SectionListContainer({
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.onAddPressed,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: XyloThemeColors.surfaceCard,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: XyloThemeColors.borderGold, width: 1.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                    decoration: BoxDecoration(
                      color: XyloThemeColors.gold.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: XyloThemeColors.gold),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        fontFamily: kXyloFont,
                        color: XyloThemeColors.goldBright,
                        fontSize: 11.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontFamily: kXyloFont,
                            fontSize: 15.5,
                            color: XyloThemeColors.textPrimary,
                            letterSpacing: 0.6,
                          ),
                        ),
                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: kXyloFont,
                            fontSize: 10,
                            color: XyloThemeColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: XyloThemeColors.gold,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: onAddPressed,
                    icon: const Icon(Icons.add_rounded, size: 16),
                    label: const Text(
                      'CREATE',
                      style: TextStyle(fontFamily: kXyloFont, fontSize: 11),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1, color: XyloThemeColors.borderSubtle),
              const SizedBox(height: 12),
              if (children.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: XyloThemeColors.bgDeep.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: XyloThemeColors.borderSubtle),
                  ),
                  child: const Center(
                    child: Text(
                      'NO ITEMS FOUND — TAP CREATE TO ADD NEW RECORD',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: kXyloFont,
                        color: XyloThemeColors.textMuted,
                        fontSize: 11.5,
                      ),
                    ),
                  ),
                )
              else
                ...children,
            ],
          ),
        ),
      ),
    );
  }
}

class _ListDownRowCard extends StatelessWidget {
  final String leadingBadge;
  final String? imageUrl;
  final String title;
  final String subtitle;
  final String metaText;
  final bool isActive;
  final ValueChanged<bool> onToggleActive;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _ListDownRowCard({
    required this.leadingBadge,
    this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.metaText,
    required this.isActive,
    required this.onToggleActive,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            XyloThemeColors.bgDeep.withValues(alpha: 0.85),
            XyloThemeColors.surfaceInput.withValues(alpha: 0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isActive
              ? XyloThemeColors.borderGold
              : XyloThemeColors.crimson.withValues(alpha: 0.6),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageUrl != null && imageUrl!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageUrl!,
                      width: 66,
                      height: 66,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 66,
                        height: 66,
                        color: XyloThemeColors.surfaceCard,
                        alignment: Alignment.center,
                        child: const Icon(Icons.image_outlined,
                            color: XyloThemeColors.gold),
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: XyloThemeColors.gold.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        leadingBadge,
                        style: const TextStyle(
                          fontFamily: kXyloFont,
                          color: XyloThemeColors.goldBright,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: kXyloFont,
                        fontSize: 15,
                        color: XyloThemeColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: kXyloFont,
                        fontSize: 11.5,
                        color: XyloThemeColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(height: 1, color: XyloThemeColors.borderSubtle),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: Text(
                  metaText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: kXyloFont,
                    fontSize: 10,
                    color: XyloThemeColors.textMuted,
                  ),
                ),
              ),
              Switch(
                value: isActive,
                activeThumbColor: XyloThemeColors.emerald,
                onChanged: onToggleActive,
              ),
              IconButton(
                tooltip: 'EDIT',
                onPressed: onEdit,
                icon: const Icon(Icons.edit_rounded,
                    color: XyloThemeColors.gold, size: 20),
              ),
              IconButton(
                tooltip: 'DELETE',
                onPressed: onDelete,
                icon: const Icon(Icons.delete_outline_rounded,
                    color: XyloThemeColors.crimson, size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CrudFormDialog extends StatefulWidget {
  final String title;
  final Future<String?> Function() onSave;
  final List<Widget> children;

  const _CrudFormDialog({
    required this.title,
    required this.onSave,
    required this.children,
  });

  @override
  State<_CrudFormDialog> createState() => _CrudFormDialogState();
}

class _CrudFormDialogState extends State<_CrudFormDialog> {
  bool _saving = false;
  String? _err;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: XyloThemeColors.surfaceCard,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: XyloThemeColors.gold, width: 1.4),
      ),
      title: Row(
        children: [
          const Icon(Icons.auto_awesome_rounded,
              color: XyloThemeColors.gold, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.title,
              style: const TextStyle(
                fontFamily: kXyloFont,
                color: XyloThemeColors.goldBright,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 540,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_err != null)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: XyloThemeColors.crimson.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: XyloThemeColors.crimson),
                  ),
                  child: Text(_err!,
                      style: const TextStyle(
                          fontFamily: kXyloFont, fontSize: 11.5)),
                ),
              ...widget.children,
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.of(context).pop(),
          child: const Text('CANCEL',
              style: TextStyle(fontFamily: kXyloFont)),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: XyloThemeColors.gold,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: _saving
              ? null
              : () async {
                  setState(() {
                    _saving = true;
                    _err = null;
                  });
                  final res = await widget.onSave();
                  if (!mounted) return;
                  if (res == null) {
                    Navigator.of(context).pop();
                  } else {
                    setState(() {
                      _saving = false;
                      _err = res;
                    });
                  }
                },
          icon: _saving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.black),
                )
              : const Icon(Icons.check_circle_rounded, size: 18),
          label: const Text('SAVE CHANGES',
              style: TextStyle(fontFamily: kXyloFont, fontSize: 12)),
        ),
      ],
    );
  }
}

class _ImagePickerBox extends StatelessWidget {
  final String currentImageUrl;
  final String? pickedFileName;
  final void Function(String? path, Uint8List? bytes, String name) onPicked;

  const _ImagePickerBox({
    required this.currentImageUrl,
    required this.pickedFileName,
    required this.onPicked,
  });

  Future<void> _pickFile() async {
    try {
      final picker = ImagePicker();
      final xfile = await picker.pickImage(source: ImageSource.gallery);
      if (xfile != null) {
        final bytes = await xfile.readAsBytes();
        onPicked(xfile.path, bytes, xfile.name);
        return;
      }
    } catch (_) {}

    if (!kIsWeb && Platform.isLinux) {
      try {
        final res = await Process.run('zenity', [
          '--file-selection',
          '--title=Select Image',
          '--file-filter=Images | *.png *.jpg *.jpeg *.webp *.gif',
        ]);
        if (res.exitCode == 0) {
          final p = res.stdout.toString().trim();
          if (p.isNotEmpty) {
            final f = File(p);
            final bytes = await f.readAsBytes();
            onPicked(p, bytes, p.split('/').last);
          }
        }
      } catch (_) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: XyloThemeColors.surfaceInput,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: XyloThemeColors.borderGold),
      ),
      child: Row(
        children: [
          const Icon(Icons.add_photo_alternate_rounded,
              color: XyloThemeColors.gold, size: 26),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              pickedFileName != null
                  ? 'SELECTED: $pickedFileName'
                  : (currentImageUrl.isNotEmpty
                      ? 'IMAGE READY'
                      : 'UPLOAD IMAGE'),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontFamily: kXyloFont, fontSize: 11.5),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: XyloThemeColors.gold.withValues(alpha: 0.2),
              foregroundColor: XyloThemeColors.goldBright,
              side: const BorderSide(color: XyloThemeColors.gold),
            ),
            onPressed: _pickFile,
            icon: const Icon(Icons.upload_file_rounded, size: 15),
            label: const Text('PICK IMAGE',
                style: TextStyle(fontFamily: kXyloFont, fontSize: 11)),
          ),
        ],
      ),
    );
  }
}