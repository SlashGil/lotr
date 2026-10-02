class ImageHelper {
  static const Map<String, String> _characterImages = {
    'aragorn': 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?q=80&w=600&auto=format&fit=crop', // Warrior/King
    'gandalf': 'https://images.unsplash.com/photo-1514539079130-25950c84af65?q=80&w=600&auto=format&fit=crop', // Wizard/Grey
    'frodo': 'https://images.unsplash.com/photo-1543610892-0b1f7e6d8ac1?q=80&w=600&auto=format&fit=crop',   // Hobbit/Ringbearer
    'legolas': 'https://images.unsplash.com/photo-1579783902614-a3fb3927b675?q=80&w=600&auto=format&fit=crop', // Elf Archer
    'gimli': 'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?q=80&w=600&auto=format&fit=crop',   // Dwarf Warrior
    'galadriel': 'https://images.unsplash.com/photo-1534447677768-be436bb09401?q=80&w=600&auto=format&fit=crop', // Elven Queen
    'sauron': 'https://images.unsplash.com/photo-1509248961158-e54f6934749c?q=80&w=600&auto=format&fit=crop',  // Dark Lord
    'arwen': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=600&auto=format&fit=crop',   // Maiden Undómiel
    'sam': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=600&auto=format&fit=crop',     // Loyal Friend
    'boromir': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=600&auto=format&fit=crop', // Gondor Shield
    'gollum': 'https://images.unsplash.com/photo-1508700115892-45ecd05ae2ad?q=80&w=600&auto=format&fit=crop',  // Creature
    'bilbo': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=600&auto=format&fit=crop',   // Hobbit Elder
    'elrond': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=600&auto=format&fit=crop',  // Lord of Rivendell
    'saruman': 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?q=80&w=600&auto=format&fit=crop', // White Wizard
  };

  static const Map<String, String> _raceImages = {
    'elf': 'https://images.unsplash.com/photo-1534447677768-be436bb09401?q=80&w=600&auto=format&fit=crop',
    'hobbit': 'https://images.unsplash.com/photo-1543610892-0b1f7e6d8ac1?q=80&w=600&auto=format&fit=crop',
    'human': 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?q=80&w=600&auto=format&fit=crop',
    'dwarf': 'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?q=80&w=600&auto=format&fit=crop',
    'maiar': 'https://images.unsplash.com/photo-1514539079130-25950c84af65?q=80&w=600&auto=format&fit=crop',
    'orc': 'https://images.unsplash.com/photo-1509248961158-e54f6934749c?q=80&w=600&auto=format&fit=crop',
  };

  static const String defaultCharacterImage =
      'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?q=80&w=600&auto=format&fit=crop';

  static String getCharacterImage(String name, String race) {
    final lowerName = name.toLowerCase();
    for (final entry in _characterImages.entries) {
      if (lowerName.contains(entry.key)) {
        return entry.value;
      }
    }
    final lowerRace = race.toLowerCase();
    for (final entry in _raceImages.entries) {
      if (lowerRace.contains(entry.key)) {
        return entry.value;
      }
    }
    return defaultCharacterImage;
  }

  static String getMovieImage(String movieName) {
    final lower = movieName.toLowerCase();
    if (lower.contains('fellowship')) {
      return 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?q=80&w=600&auto=format&fit=crop';
    } else if (lower.contains('two towers')) {
      return 'https://images.unsplash.com/photo-1519681393784-d120267933ba?q=80&w=600&auto=format&fit=crop';
    } else if (lower.contains('return of the king')) {
      return 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?q=80&w=600&auto=format&fit=crop';
    } else if (lower.contains('hobbit') || lower.contains('an unexpected journey')) {
      return 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?q=80&w=600&auto=format&fit=crop';
    }
    return 'https://images.unsplash.com/photo-1519681393784-d120267933ba?q=80&w=600&auto=format&fit=crop';
  }

  static String getBookImage(String bookName) {
    final lower = bookName.toLowerCase();
    if (lower.contains('fellowship')) {
      return 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?q=80&w=600&auto=format&fit=crop';
    } else if (lower.contains('two towers')) {
      return 'https://images.unsplash.com/photo-1512820790803-83ca734da794?q=80&w=600&auto=format&fit=crop';
    } else if (lower.contains('return of the king')) {
      return 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?q=80&w=600&auto=format&fit=crop';
    }
    return 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?q=80&w=600&auto=format&fit=crop';
  }
}
