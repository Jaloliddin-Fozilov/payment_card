import '../../../../constants/imports.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card settings'.tr),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.delete, color: Colors.red, size: 20),
            splashRadius: 20,
            onPressed: () async {
              Get.defaultDialog(
                title: 'Delete card'.tr,
                middleText: 'Are you sure you want to delete your card?'.tr,
                titleStyle: const TextStyle(color: Colors.black),
                middleTextStyle: const TextStyle(color: Colors.black),
                cancel: AppButton(
                  text: 'Cancel'.tr,
                  color: Colors.grey,
                  onTap: () => Get.back(),
                ),
                confirm: AppButton(
                  text: 'Delete'.tr,
                  color: Colors.red,
                  onTap: () async => await context.read<HomeProvider>().deleteCard(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: context.read<HomeProvider>().init(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            return Consumer<HomeProvider>(
              builder: (ctx, provider, _) {
                return ListView(
                  children: [
                    const CardWidget(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text('Choose card style'.tr,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: provider.cardBacgroundStyles.reversed
                            .map((item) => CardStyleItemWidget(cardBackgroundModel: item))
                            .toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text('Or you can create your own style'.tr,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              text: 'Choose color'.tr,
                              onTap: () async => await pickerColors(context),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: AppButton(
                              text: 'Choose image'.tr,
                              onTap: () => Get.toNamed(Routes.selectImage),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                );
              },
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: AppButton(
          width: Get.width,
          text: 'Save'.tr,
          onTap: () => context.read<HomeProvider>().saveCard(),
        ),
      ),
    );
  }
}
