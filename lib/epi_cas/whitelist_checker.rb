module EpiCas
  class WhitelistChecker < Struct.new(:raw_dn, :uid, :user_class)
    USER_GROUPS = {
      'ou=staff,ou=users,dc=sheffield,dc=ac,dc=uk'                                 => :staff,
      'ou=honorary,ou=staff,ou=users,dc=sheffield,dc=ac,dc=uk'                     => :staff_honorary,
      'ou=visiting,ou=staff,ou=users,dc=sheffield,dc=ac,dc=uk'                     => :staff_visiting,
      'ou=external,ou=users,dc=sheffield,dc=ac,dc=uk'                              => :external,
      'ou=research,ou=postgraduates,ou=students,ou=users,dc=sheffield,dc=ac,dc=uk' => :student_pg_research,
      'ou=taught,ou=postgraduates,ou=students,ou=users,dc=sheffield,dc=ac,dc=uk'   => :student_pg_taught,
      'ou=undergraduates,ou=students,ou=users,dc=sheffield,dc=ac,dc=uk'            => :student_undergraduate
    } 
  
    def allow_authentication?
      username_whitelisted? || groups_allowed_to_log_in.member?(group)
    end
  
    def allow_creation?
      username_whitelisted? || groups_allowed_to_be_created.member?(group)
    end
  
    private
      def groups_allowed_to_log_in
        @groups_allowed_to_log_in ||= settings(:groups_allowed_to_log_in).to_a.map(&:to_sym)
      end
      
      def groups_allowed_to_be_created
        @groups_allowed_to_be_created ||= settings(:groups_allowed_to_be_created).to_a.map(&:to_sym)
      end
      
      def username_whitelisted?
        (settings(:username_whitelist) || []).member? uid.to_s.downcase
      end
      
      def group
        USER_GROUPS[dn]
      end
  
      def dn
        @dn ||= raw_dn[/ou=.*dc=uk/].to_s.downcase
      end
      
      def settings(setting_name, setting_class = EpiCas::Settings)
         class_specific_settings[setting_name] || setting_class[setting_class]
      end
      
      def class_specific_settings(setting_class = EpiCas::Settings)
        @class_specific_settings ||= ((setting_class.class_specific_settings || {})[user_class.to_s]) || {}
      end
  end
end