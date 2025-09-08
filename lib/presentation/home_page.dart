import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_intern_test/presentation/cubit/search_places_cubit.dart';
import 'package:mobile_intern_test/presentation/cubit/search_places_state.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();

  Future<void> openInGoogleMaps(double lat, double lon) async {
    final Uri url = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$lat,$lon",
    );

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Search Places",
          style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Enter address",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                context.read<SearchPlacesCubit>().search(value);
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<SearchPlacesCubit, SearchPlacesState>(
                builder: (context, state) {
                  if (state is SearchPlacesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is SearchPlacesLoaded) {
                    return ListView.builder(
                      itemCount: state.locationEntity.length,
                      itemBuilder: (context, index) {
                        final location = state.locationEntity[index];
                        return ListTile(
                          title: Text(
                            location.displayName,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: Icon(Icons.add_location),
                          trailing: Icon(Icons.directions),
                          onTap: () {
                            openInGoogleMaps(location.lat, location.lon);
                          },
                        );
                      },
                      cacheExtent: 500.0,
                    );
                  }
                  if (state is SearchPlacesError) {
                    final messages = switch (state.message) {
                      'rate-limited' =>
                        'Bạn đang tìm kiếm quá nhanh, vui lòng thử lại sau 1 giây',
                      'not-found' => 'Không thể tải dữ liệu, vui lòng thử lại',
                      _ => 'Lỗi không xác định',
                    };
                    return Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        messages,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: Text(
                      "Nhập địa chỉ để tìm kiếm",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
