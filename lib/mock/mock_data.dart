class MockUser {
  const MockUser({
    required this.id,
    required this.fullName,
    required this.email,
    this.points = 0,
    this.avatar,
    this.address,
  });

  final String id;
  final String fullName;
  final String email;
  final int points;
  final String? avatar;
  final String? address;
}

class MockCampaign {
  const MockCampaign({
    required this.id,
    required this.title,
    required this.status,
    required this.organization,
    this.description = '',
    this.location = '',
    this.memberCount = 0,
    this.startDate,
    this.endDate,
    this.banner,
  });

  final String id;
  final String title;
  final String status;
  final String organization;
  final String description;
  final String location;
  final int memberCount;
  final String? startDate;
  final String? endDate;
  final String? banner;
}

class MockIncident {
  const MockIncident({
    required this.id,
    required this.title,
    required this.status,
    required this.priority,
    this.description = '',
    this.location = '',
    this.reporter = '',
    this.createdAt,
  });

  final String id;
  final String title;
  final String status;
  final String priority;
  final String description;
  final String location;
  final String reporter;
  final String? createdAt;
}

class MockOrganization {
  const MockOrganization({
    required this.id,
    required this.slug,
    required this.name,
    required this.status,
    this.description = '',
    this.memberCount = 0,
    this.location = '',
    this.banner,
  });

  final String id;
  final String slug;
  final String name;
  final String status;
  final String description;
  final int memberCount;
  final String location;
  final String? banner;
}

class MockGift {
  const MockGift({
    required this.id,
    required this.name,
    required this.pointsCost,
    this.description = '',
    this.stock = 0,
    this.image,
  });

  final String id;
  final String name;
  final int pointsCost;
  final String description;
  final int stock;
  final String? image;
}

class MockTransaction {
  const MockTransaction({
    required this.id,
    required this.title,
    required this.points,
    required this.type,
    required this.date,
  });

  final String id;
  final String title;
  final int points;
  final String type;
  final String date;
}

class MockOrder {
  const MockOrder({
    required this.id,
    required this.giftName,
    required this.points,
    required this.status,
    required this.date,
  });

  final String id;
  final String giftName;
  final int points;
  final String status;
  final String date;
}

abstract final class MockData {
  static const currentUser = MockUser(
    id: 'u1',
    fullName: 'Ngoc Nguyen',
    email: 'ngoc@ecolink.vn',
    points: 1250,
    address: 'Ho Chi Minh City, Vietnam',
  );

  static const campaigns = <MockCampaign>[
    MockCampaign(
      id: 'c1',
      title: 'Clean Saigon Riverbanks',
      status: 'active',
      organization: 'Green Saigon',
      description: 'Weekend cleanup along the river with local volunteers.',
      location: 'District 1, HCMC',
      memberCount: 48,
      startDate: '2026-08-01',
      endDate: '2026-09-30',
    ),
    MockCampaign(
      id: 'c2',
      title: 'Plastic-Free Markets',
      status: 'pending',
      organization: 'EcoLink Volunteers',
      description: 'Reduce single-use plastic at traditional markets.',
      location: 'District 5, HCMC',
      memberCount: 22,
      startDate: '2026-09-01',
      endDate: '2026-10-15',
    ),
    MockCampaign(
      id: 'c3',
      title: 'School Recycling Drive',
      status: 'completed',
      organization: 'Youth for Earth',
      description: 'Collect and sort recyclables at partner schools.',
      location: 'Thu Duc City',
      memberCount: 110,
      startDate: '2026-05-01',
      endDate: '2026-06-30',
    ),
  ];

  static const incidents = <MockIncident>[
    MockIncident(
      id: 'i1',
      title: 'Illegal dumping near park',
      status: 'open',
      priority: 'high',
      description: 'Large pile of construction waste beside the walking path.',
      location: 'Tao Dan Park',
      reporter: 'Minh Tran',
      createdAt: '2026-08-18',
    ),
    MockIncident(
      id: 'i2',
      title: 'Overflowing public bins',
      status: 'in_progress',
      priority: 'medium',
      description: 'Bins not emptied for several days.',
      location: 'Nguyen Hue Walking Street',
      reporter: 'Lan Pham',
      createdAt: '2026-08-17',
    ),
    MockIncident(
      id: 'i3',
      title: 'Oil spill on canal',
      status: 'resolved',
      priority: 'critical',
      description: 'Visible oil film on water surface.',
      location: 'Nhieu Loc Canal',
      reporter: 'Huy Le',
      createdAt: '2026-08-10',
    ),
  ];

  static const organizations = <MockOrganization>[
    MockOrganization(
      id: 'o1',
      slug: 'green-saigon',
      name: 'Green Saigon',
      status: 'approved',
      description: 'Community organization focused on urban greening.',
      memberCount: 320,
      location: 'Ho Chi Minh City',
    ),
    MockOrganization(
      id: 'o2',
      slug: 'youth-for-earth',
      name: 'Youth for Earth',
      status: 'approved',
      description: 'Student-led environmental education network.',
      memberCount: 180,
      location: 'Hanoi',
    ),
    MockOrganization(
      id: 'o3',
      slug: 'coastal-guardians',
      name: 'Coastal Guardians',
      status: 'pending',
      description: 'Protecting beaches and mangroves.',
      memberCount: 54,
      location: 'Da Nang',
    ),
  ];

  static const gifts = <MockGift>[
    MockGift(
      id: 'g1',
      name: 'Eco Tote Bag',
      pointsCost: 200,
      description: 'Reusable cotton tote with EcoLink branding.',
      stock: 40,
    ),
    MockGift(
      id: 'g2',
      name: 'Stainless Bottle',
      pointsCost: 450,
      description: '500ml insulated water bottle.',
      stock: 18,
    ),
    MockGift(
      id: 'g3',
      name: 'Tree Planting Certificate',
      pointsCost: 800,
      description: 'Sponsor one tree planted in partner forests.',
      stock: 100,
    ),
  ];

  static const transactions = <MockTransaction>[
    MockTransaction(
      id: 't1',
      title: 'Joined Clean Saigon Riverbanks',
      points: 100,
      type: 'earn',
      date: '2026-08-15',
    ),
    MockTransaction(
      id: 't2',
      title: 'Redeemed Eco Tote Bag',
      points: -200,
      type: 'spend',
      date: '2026-08-12',
    ),
    MockTransaction(
      id: 't3',
      title: 'Reported illegal dumping',
      points: 50,
      type: 'earn',
      date: '2026-08-10',
    ),
  ];

  static const orders = <MockOrder>[
    MockOrder(
      id: 'ord1',
      giftName: 'Eco Tote Bag',
      points: 200,
      status: 'completed',
      date: '2026-08-12',
    ),
    MockOrder(
      id: 'ord2',
      giftName: 'Stainless Bottle',
      points: 450,
      status: 'pending',
      date: '2026-08-19',
    ),
  ];

  static MockCampaign? campaignById(String id) {
    try {
      return campaigns.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  static MockIncident? incidentById(String id) {
    try {
      return incidents.firstWhere((i) => i.id == id);
    } catch (_) {
      return null;
    }
  }

  static MockOrganization? organizationBySlug(String slug) {
    try {
      return organizations.firstWhere((o) => o.slug == slug);
    } catch (_) {
      return null;
    }
  }
}
